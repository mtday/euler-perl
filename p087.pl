
#
# Problem 87:
#
# The smallest number expressible as the sum of a prime square, prime cube, and
# prime fourth power is 28. In fact, there are exactly four numbers below fifty
# that can be expressed in such a way:
# 
#           28 = 2**2 + 2**3 + 2**4
#           33 = 3**2 + 2**3 + 2**4
#           49 = 5**2 + 2**3 + 2**4
#           47 = 2**2 + 3**3 + 2**4
# 
# How many numbers below fifty million can be expressed as the sum of a prime
# square, prime cube, and prime fourth power?
#

# This is the upper bound on numbers.
$max = 50000000;

# This will keep track of the numbers we have identified.
%hash;

# These are the variables that will iterate through all the squares,
# cubes, and fourth powers, with each starting at 2.
$a = $b = $c = 2;

# Iterate through possible a values.
while (true) {
	# Find the fourth power.
	$a4 = $a ** 4;

	# Iterate through possible b values.
	while (true) {
		# Find the cube.
		$b3 = $b ** 3;

		# Iterate through possible c values.
		while (true) {
			# Find the square.
			$c2 = $c ** 2;

			# Find the sum value.
			$sum = $a4 + $b3 + $c2;

			# Move on if we get too high.
			last if $sum > $max;

			# Add this number to the hash.
			$hash{$sum} = 1;

			# Find the next prime for c.
			$c = next_prime($c);
		}

		# Move on if we get too high.
		last if $a4 + $b3 > $max;

		# Find the next prime for b.
		$b = next_prime($b);

		# Reset the c value.
		$c = 2;
	}

	# Finish if we get too high.
	last if $a4 > $max;

	# Find the next prime for a.
	$a = next_prime($a);

	# Reset b and c values.
	$b = $c = 2;
}

# Print the result.
print "Found: " . scalar(keys(%hash)) . "\n";


# This is used to retrieve the next prime value.
sub next_prime {
	# Get the previous prime value.
	my $p = shift;

	# The base case.
	return 3 if $p == 2;

	# Find the next prime value and return it.
	while ($p += 2) { return $p if is_prime($p); }
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

