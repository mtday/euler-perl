
#
# Problem 78:
#
# Let p(n) represent the number of different ways in which n coins can be
# separated into piles. For example, five coins can separated into piles in
# exactly seven different ways, so p(5)=7.
#
#                     OOOOO
#                     OOOO   O
#                     OOO    OO
#                     OOO    O    O
#                     OO     OO   O
#                     OO     O    O    O
#                     O      O    O    O   O
# 
# Find the least value of n for which p(n) is divisible by one million.
#

# This is the starting value for n.
$n = 1;

# Iterate until we find it.
while (++$n) {
	# Get the integer partitions for n.
	$partitions = p($n);

	# Print the result and break out if we found the answer.
	print "Found: $n ($partitions)\n" and last if ($partitions == 0);
}

# This will cache some of the values.
%pi_cache = ( );

# This is the partition function.
sub p {
	# Get the parameter.
	my $n = shift;

	# Handle the base cases.
	return 0 if $n < 0;
	return 1 if $n == 0;

	# Return the cached value if it exists.
	return $pi_cache{$n} if exists($pi_cache{$n});

	# This will hold the final sum.
	my $sum = 0;

	# Use the intermediate partition function to calculate the result.
	for $k (1 .. $n) {
		# Compute the pentagonal number for k.
		my $pent_a = $k * (3 * $k - 1) / 2;
		my $pent_b = $k * (3 * $k + 1) / 2;

		# Break out when the pentagonal number gets too high.
		last if $pent_a > $n;

		# Calculate the recursive values.
		my $ppa = p($n - $pent_a);
		my $ppb = p($n - $pent_b);


		# Add or subtract the value to the sum.
		if ($k % 2 == 0) {
			$sum += 1000000 - $ppa - $ppb;
			$sum %= 1000000;
		} else {
			$sum += $ppa + $ppb;
			$sum %= 1000000;
		}
	}

	# This will hold the number to return.
	my $ret;

	if ($sum < 1000000) {
		# Return the number directly if it is small enough.
		$ret = $sum;
	} else {
		# Return the last 6 digits of the result if it is too big.
		$ret = substr($sum, length($sum)-6, 6);
	}

	# Save this value in the cache.
	$pi_cache{$n} = $ret;

	# Return the value.
	return $ret;
}

