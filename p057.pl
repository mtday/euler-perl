
#
# Problem 57:
#
# It is possible to show that the square root of two can be expressed as an
# infinite continued fraction.
# 
#        sqrt(2) = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...
# 
# By expanding this for the first four iterations, we get:
# 
#        1 + 1/2 = 3/2 = 1.5
#        1 + 1/(2 + 1/2) = 7/5 = 1.4
#        1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
#        1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...
# 
# The next three expansions are 99/70, 239/169, and 577/408, but the eighth
# expansion, 1393/985, is the first example where the number of digits in the
# numerator exceeds the number of digits in the denominator.
# 
# In the first one-thousand expansions, how many fractions contain a numerator
# with more digits than denominator?
#

# These are the numerators and denominators for the first 8 iterations:
# 0:  1      1
# 1:  3      2
# 2:  7      5
# 3:  17     12
# 4:  41     29
# 5:  99     70
# 6:  239    169
# 7:  577    408
# 8:  1393   985
#

# Include the BigInt library.
use Math::BigInt;

# This is the number of iterations to go through.
$iters = 1000;

# This will keep track of the expansions with numerators that have more digits
# than the denominator.
$count = 0;

# These are the starting values (expansion 0).
$n = $d = Math::BigInt->new(1);

# Continue iterating until the end.
while ($iters--) {
	# Determine the next numerator and denominator.
	$old_d = $d;
	$d = $n + $d;
	$n = $old_d + $d;

	# Increment the counter if necessary.
	$count++ if (length($n) > length($d));
}

# Print the result.
print "Found: $count\n";

