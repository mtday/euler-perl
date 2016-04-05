
#
# Problem 35:
#
# The number, 197, is called a circular prime because all rotations of the
# digits: 197, 971, and 719, are themselves prime.
# 
# There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71,
# 73, 79, and 97.
# 
# How many circular primes are there below one million?
#

# Define how high we want to go.
$max = 1000000;

# This is the hash containing all the circular primes found.
%hash = ( 2 => 1 );

# Iterate over potential primes.
for ($n = 3; $n < $max; $n += 2) {
	# Skip any number that has an even digit.
	next if ($n =~ /.*[02468].*/);

	# This is used to keep track of whether all rotations are prime.
	$all_prime = true;

	# Determine the length of the number.
	$len = length($n);

	# Iteratively rotate the digits.
	for ($i = 0, $d = $n; $i < $len && $all_prime eq true; $i++) {
		# Define the square root of the value.
		$sqrt = int(sqrt $d) + 1;

		# Keep track of whether it is a prime.
		$is_prime = true;

		# Iterate from 2 to the square root to test for primality.
		for $t (2 .. $sqrt) {
			# Check to see if the potential prime is evenly divisible by $t.
			$is_prime = false and last if ($d % $t == 0);
		}

		# Break out if it is not a prime.
		$all_prime = false and last if ($is_prime eq false);

		# Move on to the next rotation of digits.
		$d = substr($d, 1, $len-1) . substr($d, 0, 1);
	}

	# Check to see if all rotations were prime.
	if ($all_prime eq true) {
		# Iterate over all rotations again.
		for ($i = 0, $d = $n; $i < $len && $all_prime eq true; $i++) {
			# Add this one to the hash.
			$hash{$d} = 1;

			# Move on to the next rotation of digits.
			$d = substr($d, 1, $len-1) . substr($d, 0, 1);
		}
	}
}

# Print the total number found.
print "Total: " . (keys %hash) . "\n";

