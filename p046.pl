
#
# Problem 46:
#
# It was proposed by Christian Goldbach that every odd composite number can be
# written as the sum of a prime and twice a square.
# 
#       9 = 7 + 2×1**2
#       15 = 7 + 2×2**2
#       21 = 3 + 2×3**2
#       25 = 7 + 2×3**2
#       27 = 19 + 2×2**2
#       33 = 31 + 2×1**2
# 
# It turns out that the conjecture was false.
# 
# What is the smallest odd composite that cannot be written as the sum of a
# prime and twice a square?
#

# The number of numbers to find.
$to_find = 1;

# This will keep track of the number found.
$found = 0;

# The starting odd composite.
$a = 9;

# The identified list of primes.
@primes = ( 2, 3, 5, 7, 11 );

# Continually iterate until we find the right number.
while ($found < $to_find) {
	# Continue to the next if this number is not composite.
	$a += 2 and next if (is_prime($a) eq true);

	# Get the biggest prime in the list.
	my $p = $primes[$#primes];

	# Find primes up to the composite odd number.
	while ($p < $a) {
		# Find the next potential prime.
		$p += 2;

		# Add it to the list if it is prime.
		push(@primes, $p) if (is_prime($p) eq true);
	}

	# This keeps track of whether we found one or not.
	$found_one = false;

	# Iterate through all the identified primes.
	for my $p (@primes) {
		# This is the number to be squared.
		$s = 1;

		# Iterate until we go too high.
		while ($p + (2 * ($s*$s)) < $a) {
			# Increment the square.
			$s++;
		}

		# We found a match, so break out.
		$found_one = true and last if ($p + (2 * ($s*$s)) == $a);
	}

	# Notify we found one when necessary.
	print "Found: $a\n" and $found++ if ($found_one ne true);

	# Move on to the next odd composite.
	$a += 2;
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

	# Iterate from 2 to the square root to test for primality.
	for my $t (2 .. $sqrt) {
		# Check to see if the potential prime is evenly divisible by $t.
		$prime = false and last if ($p % $t == 0);
	}

	# Return whether it is prime or not.
	return $prime;
}

