
#
# Problem 80:
#
# It is well known that if the square root of a natural number is not an
# integer, then it is irrational. The decimal expansion of such square roots is
# infinite without any repeating pattern at all.
# 
# The square root of two is 1.41421356237309504880..., and the digital sum of
# the first one hundred decimal digits is 475.
# 
# For the first one hundred natural numbers, find the total of the digital sums
# of the first one hundred decimal digits for all the irrational square roots.
#

# Include the BigFloat library.
use Math::BigFloat;

# This is the upper bound on numbers.
$max = 100;

# This will hold the sum of the digits.
$sum = 0;

# Iterate over the range.
for $n (2 .. $max) {
	# Skip perfect squares.
	$sq = sqrt($n); next if $sq == int($sq);

	# Get the big float for n.
	$bn = Math::BigFloat->new($n);

	# Set the precision for this number.
	$bn->precision(-103);

	# Get the square root.
	$s = $bn->bsqrt();

	# Cut off the integer portion.
	$s =~ s/\.//;

	# Trim the length.
	$s = substr($s, 0, 100);

	# This will hold the sum of the digits.
	$digit_sum = 0;

	# Add up all the digits in this number.
	$digit_sum += $_ for ((split(//, $s)));

	# Add the digit sum to the total sum.
	$sum += $digit_sum;
}

# Print the result.
print "Found: $sum\n";

