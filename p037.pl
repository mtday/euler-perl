
#
# Problem 37:
#
# The number 3797 has an interesting property. Being prime itself, it is
# possible to continuously remove digits from left to right, and remain prime
# at each stage: 3797, 797, 97, and 7. Similarly we can work from right to
# left: 3797, 379, 37, and 3.
# 
# Find the sum of the only eleven primes that are both truncatable from left to
# right and right to left.
# 
# NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
#

# The maximum number of numbers to to find.
$max = 11;

# The number found so far.
$count = 0;

# This is the sum of the identified numbers.
$sum = 0;

# This is the starting number to check.
$n = 9;

# Iterate over all the numbers up to the max.
while ($count != $max) {
	# Skip any number that has an even digit or 5 in the middle.
	$n += 2 and next if ($n =~ /.+[024568].*/);

	# This is used to keep track of whether all truncations are prime.
	$all_prime = true;

	# Determine the length of the number.
	$len = length($n);

	# Iteratively truncate the right-most digit.
	for ($i = 0, $d = $n; $i < $len && $all_prime eq true; $i++) {
		# Break out if it is not a prime.
		$all_prime = false and last if (is_prime($d) eq false);

		# Move on to the next truncation of digits.
		$d = substr($d, 0, $len-1-$i);
	}

	# Continue on if not all truncations were primes.
	$n += 2 and next if ($all_prime ne true);

	# Iteratively truncate the left-most digit.
	for ($i = 0, $d = $n; $i < $len && $all_prime eq true; $i++) {
		# Break out if it is not a prime.
		$all_prime = false and last if (is_prime($d) eq false);

		# Move on to the next truncation of digits.
		$d = substr($d, 1, $len-$i);
	}

	# Check to see if all rotations were prime.
	if ($all_prime eq true) {
		# Increase the count.
		$count++;
		print "$count - $n\n";

		# Add this value to the sum.
		$sum += $n;
	}

	# Move on to the next.
	$n += 2;
}

# This is used to determine whether a number is a prime.
sub is_prime {
	# Get the parameter.
	my $p = shift;

	# 1 is not prime, and 2 is.
	return false if ($p == 1);
	return true if ($p == 2);

	# Define the square root of the value.
	$sqrt = int(sqrt $p) + 1;

	# Keep track of whether it is a prime.
	$prime = true;

	# Iterate from 3 to the square root to test for primality.
	for my $t (2 .. $sqrt) {
		# Check to see if the potential prime is evenly divisible by $t.
		$prime = false and last if ($p % $t == 0);
	}

	# Return whether it is prime or not.
	return $prime;
}

# Print the identified sum.
print "Sum: $sum\n";

