
#
# Problem 69:
#
# Euler's Totient function, phi(n) [sometimes called the phi function], is used
# to determine the number of numbers less than n which are relatively prime to
# n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and
# relatively prime to nine, phi(9)=6.
#
# n     Relatively Prime      phi(n)     n/phi(n)
# 2     1                     1          2
# 3     1,2                   2          1.5
# 4     1,3                   2          2
# 5     1,2,3,4               4          1.25
# 6     1,5                   2          3
# 7     1,2,3,4,5,6           6          1.1666...
# 8     1,3,5,7               4          2
# 9     1,2,4,5,7,8           6          1.5
# 10    1,3,7,9               4          2.5
# 
# It can be seen that n=6 produces a maximum n/phi(n) for n <= 10.
# 
# Find the value of n <= 1,000,000 for which n/phi(n) is a maximum.
#

# This is the maximum value of n.
$limit = 1000000;

# This is the maximum n/phi(n) quotient value we have seen so far.
$max_quo = 0;

# This is the n for which the quotient was a maximum.
$max_n_found = 0;

# Iterate downwards.
for ($n = $limit; $n >= 2; $n -= 2) {
	# Get the prime factors of this number.
	@pf = get_prime_factors($n);

	# Get the phi value.
	$phi_n = phi($n);

	# Get the quotient.
	$quotient = $n / $phi_n;

	# Save the quotient if necessary.
	$max_quo = $quotient and $max_n_found = $n if ($quotient > $max_quo);
}

# Print the result.
print "Found: $max_n_found\n";

# This is used to calculate phi for a number.
sub phi {
	# Get the parameter.
	my $n = shift;

	# Retrieve the prime factors for this number.
	my @pf = get_prime_factors($n);

	# This hash will hold prime factors and their exponents.
	%pfhash = ( );

	# Iterate through the prime factors.
	for $p (@pf) {
		# Add each prime factor to the hash.
		$pfhash{$p} = exists($pfhash{$p}) ? $pfhash{$p} + 1 : 1;
	}

	# This will keep track of the phi value.
	my $phi = 1;

	# Iterate through the hash of primes and their exponents.
	while (my ($prime, $exp) = each(%pfhash)) {
		$phi *= ($prime**($exp-1)) * ($prime - 1);
	}

	# Return the identified value.
	return $phi;
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
	return $p if (is_prime($p));

	# Check if 2 is a prime factor.
	push(@f, 2) and $p = $p / 2 while ($p % 2 == 0);

	# Define the square root of the value.
	my $sqrt = int(sqrt $p) + 1;

	# Iterate from 3 to the square root to test for divisibility.
	for ($t = 3; $t <= $sqrt; $t += 2) {
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
	return false eq true if ($p == 1);
	return true eq true if ($p == 2);

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
	return $prime eq true;
}

