
#
# Problem 53:
#
# There are exactly ten ways of selecting three from five, 12345:
# 
#         123, 124, 125, 134, 135, 145, 234, 235, 245, and 345
# 
# In combinatorics, we use the notation, 5C3 = 10.
# 
# In general,
#               nCr = n! / r!(n-r)!
# 	   where r <= n, n != n * (n-1) * ... * 3 * 2 * 1, and 0! = 1.
# 
# It is not until n = 23, that a value exceeds one-million: 23C10 = 1144066.
# 
# How many values of nCr, for 1 <= n <= 100, are greater than one-million?
#

# Include the BigInt library.
use Math::BigInt;

# This will keep track of the number of values over 1 million.
$count = 0;

# Iterate through the possible values of n.
for $n (1 .. 100) {
	# Iterate through the possible values of r.
	for $r (1 .. $n) {
		# Increment the counter if necessary.
		$count++ if (C($n, $r) > 1000000);
	}
}

# Print the result.
print "Found: $count\n";

# This hash of factorial values acts as a cache to speed up the process.
%fhash = ( );

# This is used to find the number of combinations.
sub C {
	# Get the parameters as BigInt objects.
	my $n = Math::BigInt->new(shift);
	my $r = Math::BigInt->new(shift);

	# Get the cached factorial values for n and r and n-r.
	my $fn = $fhash{$n};
	my $fr = $fhash{$r};
	my $fnr = $fhash{$n - $r};

	# Update the cache with the values if necessary.
	$fn = fact($n) and $fhash{$n} = $fn if (! $fn);
	$fr = fact($r) and $fhash{$r} = $fr if (! $fr);
	$fnr = fact($n - $r) and $fhash{$n - $r} = $fnr if (! $fnr);

	# Return the value.
	return $fn / ($fr * $fnr);
}

# This is used to find a factorial.
sub fact {
	# Get the parameter.
	my $n = shift;

	# Start with the product.
	my $product = $n;

	# Iterate through the available n values.
	while ($n-- > 1) {
		# Update the product.
		$product *= $n;
	}

	# Return the identified product.
	return $product;
}

