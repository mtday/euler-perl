
#
# Problem 65:
#
# The square root of 2 can be written as an infinite continued fraction.  The
# infinite continued fraction can be written, v2 = [1;(2)], (2) indicates that
# 2 repeats ad infinitum. In a similar way, v23 = [4;(1,3,1,8)].
# 
# It turns out that the sequence of partial values of continued fractions for
# square roots provide the best rational approximations. Let us consider the
# convergents for v2.
# 
# Hence the sequence of the first ten convergents for v2 are: 1, 3/2, 7/5,
# 17/12, 41/29, 99/70, 239/169, 577/408, 1393/985, 3363/2378, ...
# 
# What is most surprising is that the important mathematical constant,
# e = [2; 1,2,1, 1,4,1, 1,6,1 , ... , 1,2k,1, ...].
# 
# The first ten terms in the sequence of convergents for e are:
# 2, 3, 8/3, 11/4, 19/7, 87/32, 106/39, 193/71, 1264/465, 1457/536, ...
# 
# The sum of digits in the numerator of the 10th convergent is 1+4+5+7=17.
# 
# Find the sum of digits in the numerator of the 100th convergent of the
# continued fraction for e.
#

# These are the numerators and denominators for the first iterations:
# 1:  2       1
# 2:  3       1
# 3:  8       3
# 4:  11      4
# 5:  19      7
# 6:  87      32
# 7:  106     39
# 8:  193     71
# 9:  1264    465
# 10: 1457    536

# Include the BigInt library.
use Math::BigInt;

# This is the number of iterations to go through.
$iters = 100;

# These are the starting values (expansion 0).
$old_n = Math::BigInt->new(1);
$old_d = Math::BigInt->new(0);
$n = Math::BigInt->new(2);
$d = Math::BigInt->new(1);

# This is the current iteration.
$i = 1;

# This is the k value.
$k = 1;

# Continue iterating until the end.
while ($i++ < $iters) {
	# Determine the next numerator and denominator.
	$older_n = $old_n;
	$old_n = $n;
	$n = $older_n + ($n * ($i % 3 == 0 ? 2 * $k : 1));
	$older_d = $old_d;
	$old_d = $d;
	$d = $older_d + ($d * ($i % 3 == 0 ? 2 * $k : 1));

	# Increment K every third time.
	$k++ if ($i % 3 == 0);
}

# Print the result.
print "Found: " . eval(join('+', split(//, $n))) . "\n";

