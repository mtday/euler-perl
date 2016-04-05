
#
# Problem 76:
#
# It is possible to write five as a sum in exactly six different ways:
# 
#     4 + 1
#     3 + 2
#     3 + 1 + 1
#     2 + 2 + 1
#     2 + 1 + 1 + 1
#     1 + 1 + 1 + 1 + 1
# 
# How many different ways can one hundred be written as a sum of at least two
# positive integers?
#

# Find and print the result.
print "Found: " . (p(100) - 1) . "\n";

# This is the partition function.
sub p {
	# Get the parameter.
	my $n = shift;

	# Handle the base cases.
	return 0 if $n < 0;
	return 1 if $n == 0;

	# This will hold the final sum.
	my $sum = 1;

	# Use the intermediate partition function to calculate the result.
	$sum += pi($_, $n-$_) for (1 .. int($n/2));

	# Return the identified value.
	return $sum;
}

# This will cache some of the values.
%pi_cache = ( );

# This is the intermediate partition function.
sub pi {
	# Get the parameters.
	my ($k, $n) = @_;

	# Handle the base cases.
	return 0 if $n < $k;
	return 1 if $k * 2 > $n;

	# Return the cached value if it exists.
	return $pi_cache{"$k:$n"} if exists($pi_cache{"$k:$n"});

	# Retrieve the next values recursively.
	my $a = pi($k, $n - $k);
	my $b = pi($k + 1, $n);

	# Save this value in the cache.
	$pi_cache{"$k:$n"} = $a + $b;

	# Return the recursive relation.
	return $a + $b;
}

