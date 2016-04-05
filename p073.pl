
#
# Problem 73:
#
# Consider the fraction, n/d, where n and d are positive integers. If n<d and
# HCF(n,d)=1, it is called a reduced proper fraction.
# 
# If we list the set of reduced proper fractions for d <= 8 in ascending order
# of size, we get:
# 
# 1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3,
# 5/7, 3/4, 4/5, 5/6, 6/7, 7/8
# 
# It can be seen that there are 3 fractions between 1/3 and 1/2.
# 
# How many fractions lie between 1/3 and 1/2 in the sorted set of reduced
# proper fractions for d <= 10,000?
#


# Refer to: http://en.wikipedia.org/wiki/Farey_sequence


$n = 10000;
$num_terms = 0;
$a = 0;
$b = 1;
$c = 1;
$d = $n;

$one3 = 1 / 3;
$one2 = 1 / 2;

while ($c < $n) {
	$k = int(($n + $b) / $d);
	$e = $k * $c - $a;
	$f = $k * $d - $b;
	$a = $c;
	$b = $d;
	$c = $e;
	$d = $f;
	$v = $a / $b;
	$num_terms++ if ($v > $one3 && $v < $one2);
}

print "Found: $num_terms\n";

