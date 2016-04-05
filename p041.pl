
#
# Problem 41:
#
# We shall say that an n-digit number is pandigital if it makes use of all the
# digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is
# also prime.
# 
# What is the largest n-digit pandigital prime that exists?
#

# The maximum number of n is 7. 1+2+3+...+8 = 36, and 1+2+3+...+9 = 45. Since
# both of these numbers are divisible by 3, they cannot be prime.
# Generate all the permutations for pandigital numbers with 7 digits.
@arr = generate_permutations('1234567');

# Look for primes in reverse.
for $n (reverse(@arr)) {
	# Find the first prime and we're done.
	print "Found: $n\n" and last if (is_prime($n) eq true);
}

# This is used to generate an array of all the possible permutations of
# the string parameter (with unique characters).
sub generate_permutations {
	# Get the parameter.
	my $str = shift;

	# This will hold all the identified permutations.
	my @perms = ( );

	# Calculate the length of the provided parameter.
	$len = length($str);

	# If the length is 2, simply add the as-is and it's reverse.
	if ($len == 2) {
		push(@perms, $str);
		push(@perms, "" . reverse($str));
	} else {
		# Iterate over all the characters in the string.
		for my $i (0 .. $len - 1) {
			# Pull a single character.
			my $x = substr($str, $i, 1);

			# Get the rest of the string, without the pulled-out char.
			my $xs = $str;
			$xs =~ s/$x//;

			# Retrieve all the permutations for the rest of the string.
			my @subarr = generate_permutations($xs);

			# Add the pulled-out character to the beginning of all the
			# sub-elements.
			foreach my $s (@subarr) {
				push(@perms, $x . $s);
			}
		}
	}

	# Return all the identified permutations.
	return @perms;
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

