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
NS_EXEC="ip netns exec $NS_NAME"
REGULAR_USER=xatier

SHADOWSOCKS_CONFIG=""

# shadowsocks local port
PROXY_SERVER="socks5://127.0.0.1:1080"

# don't load user profile
PROFILE=`sudo -u $REGULAR_USER mktemp -d`

# set cache to ramdisk
CACHE=`sudo -u $REGULAR_USER mktemp -d`

CHROMIUM_FLAGS="--proxy-server=$PROXY_SERVER --disable-sync-preferences --incognito --disk-cache-dir=$CACHE --user-data-dir=$PROFILE --disable-reading-from-canvas"
# ---------------------------------------------


set -ueo pipefail

if [ $USER != "root" ]; then
    echo "[-] This must be run as root."
    exit 1
fi

start_vpn() {
    set -x
    echo "[+] Adding network interface"

    # Create the network namespace
    ip netns add $NS_NAME

    # Start the loopback interface in the namespace
    $NS_EXEC ip addr add 127.0.0.1/8 dev lo
    $NS_EXEC ip link set lo up

    # Create virtual network interfaces that will let OpenVPN (in the
    # namespace) access the real network, and configure the interface in the
    # namespace (vpn1) to use the interface out of the namespace (vpn0) as its
    # default gateway
    ip link add vpn0 type veth peer name vpn1
    ip link set vpn0 up
    ip link set vpn1 netns $NS_NAME up

    ip addr add 10.200.200.1/24 dev vpn0
    $NS_EXEC ip addr add 10.200.200.2/24 dev vpn1
    $NS_EXEC ip route add default via 10.200.200.1 dev vpn1

    # Configure the nameserver to use inside the namespace
    mkdir -p /etc/netns/$NS_NAME
    echo 'nameserver 8.8.8.8' > /etc/netns/$NS_NAME/resolv.conf

    # IPv4 NAT
    echo "[+] Setting IPv4 NAT on $NS_NAME"
    iptables -A INPUT \! -i vpn0 -s 10.200.200.0/24 -j DROP
    iptables -t nat -A POSTROUTING -o en+ -s 10.200.200.0/24 -j MASQUERADE
    sysctl -q net.ipv4.ip_forward=1

    # Check our VPN@NS is working
    $NS_EXEC ping -c 3 www.google.com

    # XXX(xatier): try vpngate?
    # # start OpenVPN in the namespace
    # $NS_EXEC openvpn --config $NS_NAME.conf &
    # # wait for the tunnel interface to come up
    # while ! $NS_EXEC ip link show dev tun0 >/dev/null 2>&1 ; do sleep .5 ; done

    $NS_EXEC sudo -u $REGULAR_USER sslocal -c $SHADOWSOCKS_CONFIG &
    $NS_EXEC sudo -u $REGULAR_USER chromium $CHROMIUM_FLAGS &
}

stop_vpn() {
    set -x

    echo "[+] Killing applications"
    ip netns pids $NS_NAME | xargs -rd'\n' kill
    sleep 5

    # clear NAT
    echo "[+] Cleaning IPv4 NAT on $NS_NAME"
    iptables -D INPUT \! -i vpn0 -s 10.200.200.0/24 -j DROP
    iptables -t nat -D POSTROUTING -o en+ -s 10.200.200.0/24 -j MASQUERADE
    sysctl -q net.ipv4.ip_forward=0

    echo "[+] Deleting network interface"
    rm -rf /etc/netns/$NS_NAME
    ip netns delete $NS_NAME
    ip link delete vpn0
}



if [ $1 == "start" ]; then
    echo "[+] Starting VPN"
    start_vpn
elif [ $1 == "stop" ]; then
    echo "[+] Stopping VPN"
    stop_vpn
else
    echo "Usage: sudo v.sh start|stop"
fi

