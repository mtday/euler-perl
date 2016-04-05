
#
# Problem 49:
#
# The arithmetic sequence, 1487, 4817, 8147, in which each of the terms
# increases by 3330, is unusual in two ways: (i) each of the three terms are
# prime, and, (ii) each of the 4-digit numbers are permutations of one another.
# 
# There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes,
# exhibiting this property, but there is one other 4-digit increasing sequence.
# 
# What 12-digit number do you form by concatenating the three terms in this
# sequence?
#

# Specify the bounds.
$low = 1001, $high = 3333;

# Iterate over all the numbers in the range.
for ($n = $low; $n <= $high; $n += 2) {
	# Skip this number if it is not prime.
	next if (is_prime($n) ne true);

	# This array will hold the primes.
	@primes = ( );

	# Get the permutations for this number.
	@perms = generate_permutations($n);

	# Determine the unique permutations for this number.
	%seen = ();
	@uniq = grep { ! $seen{$_} ++ } @perms;

	# Find the unique permutations that are primes.
	for $perm (sort(@uniq)) {
		# Skip this one if it is a duplicate.
		next if ($perm == $n);

		# Add this permutation to the list if it is prime.
		push(@primes, $perm) if (is_prime($perm) eq true);
	}

	# No need to continue if we did not find enough prime permutations.
	next if (scalar(@primes) < 2);

	# Iterate through the available prime permutations for this number
	# to check for a sequence.
	for $p1 (@primes) {
		next if $p1 < $n;
		for $p2 (@primes) {
			next if $p2 < $p1;

			# Print the message if we find one.
			print "  Found: $n, $p1, $p2: $n$p1$p2\n"
				if ($p1 - $n == $p2 - $p1);
		}
	}
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

# This is used to generate an array of all the possible permutations of
# the string parameter (with unique characters).
sub generate_permutations {
	# Get the parameter.
	my $str = shift;

	# This will hold all the identified permutations.
	my @perms = ( );

	# Calculate the length of the provided parameter.
	my $len = length($str);

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
			@split = split(//, $str);
			splice(@split, $i, 1);
			my $xs = join('', @split);

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

