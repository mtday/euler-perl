
#
# Problem 72:
#
# Consider the fraction, n/d, where n and d are positive integers. If n<d and
# HCF(n,d)=1, it is called a reduced proper fraction.
# 
# If we list the set of reduced proper fractions for d <= 8 in ascending order
# of size, we get:
# 
# 1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3,
# 5/7, 3/4, 4/5, 5/6, 6/7, 7/8
# 
# It can be seen that there are 21 elements in this set.
# 
# How many elements would be contained in the set of reduced proper fractions
# for d <= 1,000,000?
#

# This is the upper limit value.
$limit = 1000000;

# This will keep track of the total elements.
$sum = 0;

# Iterate through the range.
for $n (2 .. $limit) {
	# Add the phi of this n.
	$sum += phi($n);
}

# Print the result.
print "Found: $sum\n";


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

