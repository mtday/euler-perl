
#
# Problem 70:
#
# Euler's Totient function, phi(n), is used to determine the number of positive
# numbers less than or equal to n which are relatively prime to n. For example,
# as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively prime to nine,
# phi(9)=6. The number 1 is considered to be relatively prime to every positive
# number, so phi(1)=1.
# 
# Interestingly, phi(87109)=79180, and it can be seen that 87109 is a permutation
# of 79180.
# 
# Find the value of n, 1 < n < 10**7, for which phi(n) is a permutation of n and
# the ratio n/phi(n) produces a minimum.
#

# This is the upper limit.
$limit = 10**7;

# This is the minimum n/phi(n) quotient value we have seen so far.
$min_quo = undef;

# This is the n for which the quotient was a minimum.
$n_found = 0;

# Iterate downwards.
for ($n = $limit; $n >= 2; $n--) {
	# Get the prime factors of this number.
	@pf = get_prime_factors($n);

	# Get the phi value.
	$phi_n = phi($n);

	# Check to see if they are permutations.
	next if (join('', sort(split(//, $phi_n))) ne join('', sort(split//, $n)));

	# Get the quotient.
	$quotient = $n / $phi_n;

	# Save the quotient if necessary.
	print "Found one - phi($n) = $phi_n\n" and
	$min_quo = $quotient and $n_found = $n
		if ($min_quo == undef || $quotient < $min_quo);
}

# Print the result.
print "Found: $n_found\n";

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

