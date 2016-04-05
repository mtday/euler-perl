
#
# Problem 51:
#
# By replacing the 1st digit of *57, it turns out that six of the possible
# values: 157, 257, 457, 557, 757, and 857, are all prime.
# 
# By replacing the 3rd and 4th digits of 56**3 with the same digit, this
# 5-digit number is the first example having seven primes, yielding the family:
# 56003, 56113, 56333, 56443, 56663, 56773, and 56993. Consequently 56003,
# being the first member of this family, is the smallest prime with this
# property.
# 
# Find the smallest prime which, by replacing part of the number (not
# necessarily adjacent digits) with the same digit, is part of an eight prime
# value family.
#

# The size of the family we are looking for.
$family_size = 8;

# Continually iterate until we find a family.
for ($p = 101; ; $p += 2) {
	# Skip if not a prime.
	next if (is_prime($p) ne true);

	# Determine the unique digits in this number.
	%seen = ();
	@uniq = grep { ! $seen{$_} ++ } split(//, $p);

	# Iterate to determine the number of digits to change.
	for $d (@uniq) {
		# Keep track of the family size.
		$famsize = 0;

		@fnums = ( );

		# Iterate over the possible digits to set.
		for ($n = 0; $n <= 9; $n++) {
			# Generate the new number.
			$fnum = $p;
			$fnum =~ s/$d/$n/g;

			# Skip numbers that start with 0.
			next if ($fnum =~ /^0.*/);

			# Update the family size if we found a prime.
			$famsize++ and push(@fnums, $fnum) if (is_prime($fnum) eq true);
		}

		# Print the message.
		print "List:\n  $p\n  " . join("\n  ", @fnums) . "\n" and
		print "Found $p by changing the $d digits\n" and exit
			if ($famsize == $family_size);
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

# This is used to generate an array of all the possible combinations of
# the string parameter (with unique characters).
sub generate_combinations {
	# Get the parameter.
	my $str = shift;

	# Get the number to choose.
	my $choose = shift;

	# This will hold all the identified combinations.
	my @combs = ( );

	# Calculate the length of the provided parameter.
	my $len = length($str);

	# If the length is what we are looking for, simply add the value.
	if ($len == $choose) {
		push(@combs, $str);
	} elsif ($choose == 1) {
		# Iterate over all the characters in the string.
		for my $i (0 .. $len - 1) {
			# Add each character individually.
			push(@combs, substr($str, $i, 1));
		}
	} else {
		# Iterate over all the characters in the string.
		for my $i (0 .. $len - 1) {
			# Convert the string into an array.
			@xs = split(//, $str);

			# Pull a single character.
			my $x = splice(@xs, $i, 1);

			# Chop off up to the index.
			splice(@xs, 0, $i);

			# Retrieve all the combinations for the rest of the string.
			my @subarr = generate_combinations(join('', @xs), $choose - 1);

			# Add the pulled-out character to the beginning of all the
			# sub-elements.
			foreach my $s (@subarr) {
				push(@combs, $x . $s);
			}
		}
	}

	# Return all the identified combinations.
	return @combs;
}

