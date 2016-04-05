
#
# Problem 50:
#
# The prime 41, can be written as the sum of six consecutive primes:
#        41 = 2 + 3 + 5 + 7 + 11 + 13
# 
# This is the longest sum of consecutive primes that adds to a prime below
# one-hundred.
# 
# The longest sum of consecutive primes below one-thousand that adds to a
# prime, contains 21 terms, and is equal to 953.
# 
# Which prime, below one-million, can be written as the sum of the most
# consecutive primes?
#

# Specify the maximum value.
$max = 1000000;

# This is longest number of consecutive primes to check for.
$prime_count = 800;

# This is prime found.
$prime = 0;

# This will hold the primes.
%primes = ( 2 => 1 );

# Iterate to find all the primes in the range.
for ($p = 3; $p <= $max; $p += 2) {
	# Skip if not a prime.
	next if (is_prime($p) ne true);

	# Add to the hash of primes.
	$primes{$p} = 1;
}

# Convert the primes into a list.
@plist = sort { $a <=> $b } (keys(%primes));

# Continually look for longer strings of primes.
while (--$prime_count) {
	# Get the array slice we will sum.
	@slice = @plist[$pi .. $pi + $prime_count - 1];

	# Get the sum of the slice.
	$sum = eval(join('+', @slice));

	# Move on if this is sum is too high.
	next if ($sum > $max);

	# Note that we found a prime and break out.
	$prime = $sum and last if ($primes{$sum} ne undef);

	# Keep track of whether we found a prime.
	$found_prime = false;

	# Iterate over the primes.
	for $pi (0 .. $#plist - $prime_count + 1) {
		# Get the new sum.
		$sum = $sum - $plist[$pi] + $plist[$pi + $prime_count];

		# Move on if this is not prime, or if the sum is too high.
		next if ($sum > $max || $primes{$sum} eq undef);

		# Note that we found a prime and break out.
		$prime = $sum and $found_prime = true and last;
	}

	# Break out if we found a prime.
	last if ($found_prime eq true);
}

# Print the result.
print "Found: $prime (" . ($prime_count) . " consecutive primes)\n";


# This is used to determine whether a number is a prime.
sub is_prime {
	# Get the parameter.
	my $p = shift;

	# 1 is not prime, and 2 is.
	return false if ($p == 1);
	return true if ($p == 2);

	# Define the square root of the value.
	my $sqrt = int(sqrt $p) + 1;

	# Keep track of whether it is a prime.
	my $prime = true;

	# Iterate from 2 to the square root to test for primality.
	for my $t (2 .. $sqrt) {
		# Check to see if the potential prime is evenly divisible by $t.
		$prime = false and last if ($p % $t == 0);
	}

	# Return whether it is prime or not.
	return $prime;
}

