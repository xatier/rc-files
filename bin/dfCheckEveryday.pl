#!/usr/bin/perl
$lim = shift // 85;
@disk = split /\n/, `df`;
$O3O = 0;
for (1 .. @disk) {
  @ker = split /\s+/, @disk[$_];
  if (substr($ker[4], 0, -1) >= $lim) {
    print "=.= warning: $ker[5] will be full! now: $ker[4]\n";
     $O3O |= 1;
  }
}
if ($O3O > 0) {
  print "== df =====================================================\n";
  print `df -h`;
  print "===========================================================\n";
}
