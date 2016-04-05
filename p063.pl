
#
# Problem 63:
#
# The 5-digit number, 16807=7**5, is also a fifth power. Similarly, the 9-digit
# number, 134217728=8**9, is a ninth power.
# 
# How many n-digit positive integers exist which are also an nth power?
#

# Include the BigInt library.
use Math::BigInt;

# This will keep count.
$count = 0;

# This is the starting value minus 1.
$n = Math::BigInt->new(0);

# Iterate until we are done.
while (++$n) {
	# This is the power to start with minus 1.
	my $p = Math::BigInt->new(0);

	# Iterate until we are done.
	while (++$p) {
		# Determine the value.
		my $v = $n ** $p;

		# Determine the length of the value.
		$len = length($v);

		# Increment the counter if the length is correct.
		$count++ if ($len == $p);

		# Break out when we no longer meet the criteria.
		last if ($len != $p);
	}

	# Break out if we did not find any.
	last if $p == 1;
}

# Print the result.
print "Found: $count\n";

