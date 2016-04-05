
#
# Problem 27:
#
# Euler published the remarkable quadratic formula:
# 
# n**2 + n + 41
# 
# It turns out that the formula will produce 40 primes for the consecutive
# values n = 0 to 39. However, when n = 40, 40**2 + 40 + 41 = 40(40 + 1) + 41 is
# divisible by 41, and certainly when n = 41, 41**2 + 41 + 41 is clearly
# divisible by 41.
# 
# Using computers, the incredible formula  n**2 - 79n + 1601 was discovered,
# which produces 80 primes for the consecutive values n = 0 to 79. The product
# of the coefficients, -79 and 1601, is -126479.
# 
# Considering quadratics of the form:
# 
# 	n**2 + an + b, where |a| < 1000 and |b| < 1000
# 
# 	                            where |n| is the modulus/absolute value of n
# 	                            e.g. |11| = 11 and |-4| = 4
# 
# Find the product of the coefficients, a and b, for the quadratic expression
# that produces the maximum number of primes for consecutive values of n,
# starting with n = 0.
#

# This defines the maximum value in the range.
$max = 1000;

# This will hold the product of the coefficients.
$saved_product = 0;

# This will keep track of the maximum number of primes found.
$max_primes = 0;

# Iterate from -999 to 999.
for $a (0 - $max + 1 .. $max - 1) {
	# Iterate from -999 to 999.
	for $b (0 - $max + 1 .. $max - 1) {
		# Keep iterating while we find primes.
		for ($n = 0; true; $n++) {
			# Calculate the value.
			$val = ($n * $n) + ($a * $n) + $b;

			# Make sure it is positive.
			$val = 0 - $val if ($val < 0);

			# Define the square root of the value.
			$sqrt = int(sqrt $val) + 1;

			# Keep track of whether it is a prime.
			$is_prime = true;

			# Iterate from 2 to the square root to test for primality.
			for $t (2 .. $sqrt) {
				# Check to see if the potential prime is evenly divisible by $t.
				$is_prime = false and last if ($val % $t == 0);
			}

			# Break out if it is not a prime.
			last if ($is_prime eq false);
		}

		# Keep track of the product of a and b and the max primes.
		$max_primes = $n and $saved_product = $a * $b if ($n > $max_primes);
	}
}

# Print the result.
print "Found: $saved_product\n";

