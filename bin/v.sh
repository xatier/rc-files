#!/bin/sh

# this script is modified from
# https://unix.stackexchange.com/questions/270883/trying-to-run-openvpn-in-network-namespace

# start openvpn tunnel and torrent client inside Linux network namespace
#
# this is a fork of schnouki's script, see original blog post
# https://schnouki.net/posts/2014/12/12/openvpn-for-a-single-application-on-linux/
#
# original script can be found here
# https://gist.github.com/Schnouki/fd171bcb2d8c556e8fdf

# ------------ adjust values below ------------
# network namespace
NS_NAME=foo
NS_SUBNET="10.200.200"
OUT_IF="${NS_NAME}0"
IN_IF="${NS_NAME}1"
NS_EXEC="ip netns exec $NS_NAME"
REGULAR_USER=xatier

SHADOWSOCKS_CONFIG=""
OPENVPN_CONFIG=""

# path to rc-files/bin/vpngate
VPNGATE=""

# shadowsocks local port
PROXY_SERVER="socks5://127.0.0.1:1080"

# OpenConnect settings
OC_VPN_ENDPOINT=""
OC_VPN_USER=""

# don't load user profile
PROFILE=$(sudo -u "$REGULAR_USER" mktemp -d)

# set cache to ramdisk
CACHE=$(sudo -u "$REGULAR_USER" mktemp -d)

CHROMIUM_FLAGS="--disable-sync-preferences --incognito --disk-cache-dir=$CACHE --user-data-dir=$PROFILE --disable-reading-from-canvas"
# ---------------------------------------------

set -ueo pipefail

if [ "$USER" != "root" ]; then
    echo "[-] This must be run as root."
    exit 1
fi

start_vpn() {
    VPN=$1
    set -x
    echo "[+] Adding network interface"

    # Create the network namespace
    ip netns add "$NS_NAME"

    # Start the loopback interface in the namespace
    $NS_EXEC ip addr add 127.0.0.1/8 dev lo
    $NS_EXEC ip link set lo up

    # Create virtual network interfaces that will let OpenVPN (in the
    # namespace) access the real network, and configure the interface in the
    # namespace (NS_NAME1) to use the interface out of the namespace (NS_NAME0) as its
    # default gateway
    ip link add "$OUT_IF" type veth peer name "$IN_IF"
    ip link set "$OUT_IF" up
    ip link set "$IN_IF" netns "$NS_NAME" up

    ip addr add "$NS_SUBNET".1/24 dev "$OUT_IF"
    $NS_EXEC ip addr add "$NS_SUBNET".2/24 dev "$IN_IF"
    $NS_EXEC ip route add default via "$NS_SUBNET".1 dev "$IN_IF"

    # Configure the nameserver to use inside the namespace
    mkdir -p "/etc/netns/$NS_NAME"
    echo 'nameserver 8.8.8.8' >"/etc/netns/$NS_NAME/resolv.conf"

    # IPv4 NAT
    echo "[+] Setting IPv4 NAT on $NS_NAME"
    iptables -A INPUT \! -i "$OUT_IF" -s "$NS_SUBNET".0/24 -j DROP
    iptables -t nat -A POSTROUTING -o en+ -s "$NS_SUBNET".0/24 -j MASQUERADE
    sysctl -q net.ipv4.ip_forward=1

    # Check our VPN@NS is working
    $NS_EXEC ping -c 3 www.google.com

    if [ "$VPN" = "ovpn" ]; then
        if [ -n "$OPENVPN_CONFIG" ]; then
            cp "$OPENVPN_CONFIG" "$NS_NAME".ovpn
        else
            # select a server from vpngate project
            $NS_EXEC "$VPNGATE" "$NS_NAME"
        fi

        # start OpenVPN in the namespace
        $NS_EXEC openvpn --config "$NS_NAME".ovpn &

        # wait for the tunnel interface to come up
        while ! $NS_EXEC ip link show dev tun0 >/dev/null 2>&1; do
            sleep .5
        done

    elif [ "$VPN" = "ss" ]; then
        # start shadowdocks in the namespace
        $NS_EXEC sudo -u "$REGULAR_USER" sslocal -c "$SHADOWSOCKS_CONFIG" &
        CHROMIUM_FLAGS="--proxy-server=$PROXY_SERVER $CHROMIUM_FLAGS"

    elif [ "$VPN" = "openconnect" ]; then

        # patch resolv.conf with private nameservers
        cat <<EOF >>/etc/netns/$NS_NAME/resolv.conf
EOF
        # patch hosts for go links
        cat <<EOF >>/etc/netns/$NS_NAME/hosts
10.xxx.xxx.xxx go
EOF
        # copy nsswitch.conf inside network namespace to avoid using systemd-resolved
        # see https://github.com/slingamn/namespaced-openvpn/issues/7
        # https://www.freedesktop.org/software/systemd/man/nss-resolve.html
        cp nsswitch.conf "/etc/netns/$NS_NAME/nsswitch.conf"
        # OpenConnect requires smaller MTU
        $NS_EXEC ip link set dev "$IN_IF" mtu 1320

        # read VPN password
        read -rp "VPN Password: " VPN_PASS

        # start OpenConnect in the namespace
        echo -e "$VPN_PASS\ny" | $NS_EXEC /usr/sbin/openconnect --interface tun0 "$OC_VPN_ENDPOINT" -u "$OC_VPN_USER" --passwd-on-stdin &

        # wait for the tunnel interface to come up
        while ! $NS_EXEC ip link show dev tun0 >/dev/null 2>&1; do
            sleep .5
        done
    else
        echo "[-] no vpn is set?! Are you sure?"
    fi

    # start chromium
    $NS_EXEC sudo -u "$REGULAR_USER" chromium $CHROMIUM_FLAGS &
}

stop_vpn() {
    set -x

    if [ ! -f "/var/run/netns/$NS_NAME" ]; then
        echo "[-] no such NS named $NS_NAME"
        exit 1
    fi

    echo "[+] Killing applications"

    NS_PIDS="ip netns pids $NS_NAME"
    while [ -n "$($NS_PIDS | xargs)" ]; do
        $NS_PIDS | xargs -rd'\n' kill
        sleep .5
    done

    # clear NAT
    echo "[+] Cleaning IPv4 NAT on $NS_NAME"
    iptables -D INPUT \! -i "$OUT_IF" -s "$NS_SUBNET".0/24 -j DROP
    iptables -t nat -D POSTROUTING -o en+ -s "$NS_SUBNET".0/24 -j MASQUERADE
    sysctl -q net.ipv4.ip_forward=0

    echo "[+] Deleting network interface"
    rm -rf "/etc/netns/$NS_NAME"
    rm -f "$NS_NAME.ovpn"
    ip netns delete "$NS_NAME"
    ip link delete "$OUT_IF"
}

if [ "$1" = "start" ]; then
    echo "[+] Starting VPN"
    start_vpn "$2"
elif [ "$1" = "stop" ]; then
    echo "[+] Stopping VPN"
    stop_vpn
else
    echo "Usage: sudo v.sh start ss|ovpn|openconnect"
    echo "       sudo v.sh stop"
fi
