
#
# Problem 71:
#
# Consider the fraction, n/d, where n and d are positive integers. If n<d and
# HCF(n,d)=1, it is called a reduced proper fraction.
# 
# If we list the set of reduced proper fractions for d = 8 in ascending order
# of size, we get:
# 
# 1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3,
# 5/7, 3/4, 4/5, 5/6, 6/7, 7/8
# 
# It can be seen that 2/5 is the fraction immediately to the left of 3/7.
# 
# By listing the set of reduced proper fractions for d <= 1,000,000 in ascending
# order of size, find the numerator of the fraction immediately to the left of
# 3/7.
#

# This is the upper limit value.
$limit = 1000000;

# We are looking for the value just before this one:
@h = ( 3, 7, 3/7 ); # 3/7

# This is used to keep track of the low value in the range.
@l = ( 2, 7, 2/7 ); # 2/7

# This will iterate through our denominators.
$d = $limit+1;

# Iterate while we have denominators.
while (--$d > 1) {
	# Start with the numerator of the low boundary.
	$n = $l[0]-1;

	# Get the fraction value.
	$v = $n / $d;

	# Iterate while the fraction value is in range.
	while ($v < $h[2]) {
		# Update the hash and the low value if necessary.
		@l = ($n, $d, $v) if ($v >= $l[2]);

		# Move on to the next value.
		$v = ++$n / $d;
	}
}

# Print the result.
print "Found: $l[0]\n";

