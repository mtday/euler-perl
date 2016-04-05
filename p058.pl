
#
# Problem 58:
#
# Starting with 1 and spiralling anticlockwise in the following way, a square
# spiral with side length 7 is formed.
# 
#                        37 36 35 34 33 32 31
#                        38 17 16 15 14 13 30
#                        39 18  5  4  3 12 29
#                        40 19  6  1  2 11 28
#                        41 20  7  8  9 10 27
#                        42 21 22 23 24 25 26
#                        43 44 45 46 47 48 49
# 
# It is interesting to note that the odd squares lie along the bottom right
# diagonal, but what is more interesting is that 8 out of the 13 numbers lying
# along both diagonals are prime; that is, a ratio of 8/13 ˜ 62%.
# 
# If one complete new layer is wrapped around the spiral above, a square spiral
# with side length 9 will be formed. If this process is continued, what is the
# side length of the square spiral for which the ratio of primes along both
# diagonals first falls below 10%?
#

# Define the starting square size.
$size = 3;

# This is the size of the square with diagonal values already in the hash.
$diags_size = 1;

# This keeps track of the number of primes in the diagonals.
$dprimes = 0;

# This keeps track of the number of numbers in the diagonals.
$dvals = 1;

# Iterate until we are done.
while (true) {
	# This is the starting value.
	$n = $size * $size;

	# Iterate over each grid size.
	for ($s = $size; $s > $diags_size; $s -= 2) {
		# Iterate over the last three corners in this grid, and the first
		# (top-right) corner of the next grid.
		foreach (1 .. 4) {
			# Calculate the value of this corner.
			$n -= $s - 1;

			# Update the number of values in the diagonal (to include $n).
			$dvals++;

			# Increment if this number is prime.
			$dprimes++ if (is_prime($n));
		}
	}

	# Update the diagonal size.
	print "Found Size: $size\n" and last if ($dprimes / $dvals < 0.1);

	# Update the diagonal size.
	$diags_size = $size;

	# Move on to the next size;
	$size += 2;
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

