#!/usr/bin/perl

#####################################################
# OpenVPN config tool for vpngate
# http://www.vpngate.net/en/
#
# get OpenVPN config files from vpngate server list
#
# Author: @xatierlikelee
# License: GPL
#####################################################

use 5.018;
use utf8;
no warnings;

use LWP::Simple;
use MIME::Base64;

# you can find other mirrors here: https://github.com/waylau/vpngate-mirrors
my $API_url = 'http://www.vpngate.net/api/iphone/';
my @servers = split /\n/, get($API_url);
shift @servers;

sub hostname     { (split /,/, $_[0])[0]; }
sub country_code { (split /,/, $_[0])[6]; }
sub config_b64   { (split /,/, $_[0])[14]; }
sub pprint {
  say (join "\t\t", (split /,/, $_[0])[0,1,2, 3,6,8,12]);
}

my $cols = shift @servers;
pprint($cols);

my @jp = grep { country_code($_) eq 'JP' } @servers;
my @us = grep { country_code($_) eq 'US' } @servers;
my @au = grep { country_code($_) eq 'AU' } @servers;
my @nz = grep { country_code($_) eq 'NZ' } @servers;

pprint $_ for @jp;
pprint $_ for @us;
pprint $_ for @au;
pprint $_ for @nz;

print 'hostname: ';
my $input = <>;
chomp($input);

if ($input =~ /^vpn\d+$/) {
  open F, '>', "$input.ovpn";
  my $config = config_b64((grep { hostname($_) eq $input } @servers)[0]);
  print F decode_base64($config);
  say "save OpenVPN config to $input.ovpn ->  sudo openvpn $input.ovpn";
  close F;
}

=columns

HostName,IP,Score,Ping,Speed,CountryLong,CountryShort,NumVpnSessions,Uptime,
TotalUsers,TotalTraffic,LogType,Operator,Message,OpenVPN_ConfigData_Base64
0 => #HostName
1 => IP
2 => Score
3 => Ping
4 => Speed
5 => CountryLong
6 => CountryShort
7 => NumVpnSessions
8 => Uptime
9 => TotalUsers
10 => TotalTraffic
11 => LogType
12 => Operator
13 => Message
14 => OpenVPN_ConfigData_Base6
=cut
