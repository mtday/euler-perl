
#
# Problem 47:
#
# The first two consecutive numbers to have two distinct prime factors are:
# 
#          14 = 2 × 7
#          15 = 3 × 5
# 
# The first three consecutive numbers to have three distinct prime factors are:
# 
#          644 = 2**2 × 7 × 23
#          645 = 3 × 5 × 43
#          646 = 2 × 17 × 19.
# 
# Find the first four consecutive integers to have four distinct primes
# factors. What is the first of these numbers?
#

# The number of distinct prime factors we are looking for.
$distinct = 4;

# The starting number.
$n = 2;

# Iterate until we find the answer.
while ($n++) {
	# This will hold the combined list of prime factors.
	@list = ( );

	# Iterate over consecutive numbers.
	for ($i = 0; $i < $distinct; $i++) {
		# Get the prime factors for this number.
		@pf = get_prime_factors($n + $i);

		# Determine the unique prime factors for this number.
		%seen = ();
		@uniq = grep { ! $seen{$_} ++ } @pf;

		# Add the unique prime factors for this number to the list.
		push(@list, @uniq);
	}

	# Check to see if the number of unique factors is correct.
	print "Found $n\n" and last if ($#list + 1 == $distinct * $distinct);
}

# This is used to retrieve the sorted list of prime factors for the parameter.
sub get_prime_factors {
	# Get the parameter.
	my $p = shift;

	# This will hold the prime factors.
	my @f = ( );

	# No prime factors for the number 1.
	return @f if ($p == 1);

	# If it is already a prime, return it.
	return $p if (is_prime($p) eq true);

	# Check if 2 is a prime factor.
	push(@f, 2) and $p = $p / 2 while ($p % 2 == 0);

	# Define the square root of the value.
	$sqrt = int(sqrt $p) + 1;

	# Iterate from 3 to the square root to test for divisibility.
	for ($t = 3; $t <= $sqrt; $t += 2) {
		# Continue on if this number is not prime.
		next if (is_prime($t) eq false);

		# If it is divisible by this prime, the prime is a factor.
		push(@f, $t) and $p = $p / $t and last if ($p % $t == 0);
	}

	# Get the rest of the prime factors.
	push(@f, get_prime_factors($p));

	# Return the identified list of prime factors.
	return @f;
}

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

	# Iterate from 3 to the square root to test for primality.
	for my $t (2 .. $sqrt) {
		# Check to see if the potential prime is evenly divisible by $t.
		$prime = false and last if ($p % $t == 0);
	}

	# Return whether it is prime or not.
	return $prime;
}

