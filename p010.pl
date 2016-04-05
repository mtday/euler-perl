
#
# Problem 10:
#
# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
#
# Find the sum of all the primes below two million.
#

use Math::BigInt;

# This is the max prime value.
$max = 2000000;

# Set the starting values.
$sum = Math::BigInt->new(5);

# This is the identified prime.
$current_prime = 3;

# Iterate until we find it.
while (true) {
	# Move to the next potential prime.
	$current_prime += 2;

	# Break out once we go too far.
	last if $current_prime >= $max;

	# Define the square root of the current prime.
	$sqrt = int(sqrt $current_prime) + 1;

	# Keep track of whether it is a prime.
	$is_prime = true;

	# Iterate from 2 to the square root to test for primality.
	for $t (2 .. $sqrt) {
		# Check to see if the potential prime is evenly divisible by $t.
		$is_prime = false and last if ($current_prime % $t == 0);
	}

	# Add the prime to the sum.
	$sum += $current_prime if ($is_prime eq true);
}

# Print the sum.
print "Found: $sum\n";

