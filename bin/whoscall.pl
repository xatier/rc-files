#!/usr/bin/perl

use 5.014;

my $number = join "", @ARGV;

chomp $number;

$number =~ s/\s+//g;
$number =~ s/^09/8869/;
$number =~ s/\+886/886/;

say $number;

say "Wrong number: @ARGV" and exit if $number !~ /^\d{12}$/;
say `w3m -dump http://whoscall.com/number/$number/?country_code=tw | tail -n+12 | head -n-24`;
