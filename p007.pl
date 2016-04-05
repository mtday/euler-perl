
#
# Problem 7:
#
# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
# that the 6th prime is 13.
# 
# What is the 10001st prime number?
#

# This is the prime we are looking for.
$looking_for = 10000;

# This is the identified prime.
$current_prime = 3;

# This is number of primes found.
$primes_found = 2;

# Iterate until we find it.
while (true) {
	# Move to the next potential prime.
	$current_prime += 2;

	# Define the square root of the current prime.
	$sqrt = int(sqrt $current_prime) + 1;

	# Keep track of whether it is a prime.
	$is_prime = true;

	# Iterate from 2 to the square root to test for primality.
	for $t (2 .. $sqrt) {
		# Check to see if the potential prime is evenly divisible by $t.
		$is_prime = false and last if ($current_prime % $t == 0);
	}

	# Note that we found another prime.
	$primes_found++ if ($is_prime eq true);

	# Break out once we find it.
	last if $primes_found == $looking_for;
}

# Print the result.
print "Prime $primes_found: $current_prime\n";

