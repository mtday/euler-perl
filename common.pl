

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


# This is used to retrieve the sorted list of prime factors for the parameter.
sub get_prime_factors {
	# Get the parameter.
	my $p = shift;

	# This will hold the prime factors.
	my @f = ( );

	# No prime factors for the number 1.
	return @f if ($p == 1);

	# If it is already a prime, return it.
	return $p if (is_prime($p));

	# Check if 2 is a prime factor.
	push(@f, 2) and $p = $p / 2 while ($p % 2 == 0);

	# Define the square root of the value.
	my $sqrt = int(sqrt $p) + 1;

	# Iterate from 3 to the square root to test for divisibility.
	for ($t = 3; $t <= $sqrt; $t += 2) {
		# If it is divisible by this prime, the prime is a factor.
		push(@f, $t) and $p = $p / $t and last if ($p % $t == 0);
	}

	# Get the rest of the prime factors.
	push(@f, get_prime_factors($p));

	# Return the identified list of prime factors.
	return @f;
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

# This is used to generate an array of all the possible combinations of
# the string parameter (with unique characters).
sub generate_combinations_from_list {
	# Get the number to choose.
	my $choose = shift;

	# Get the list.
	my @arr = @_;

	# This will hold all the identified combinations.
	my @combs = ( );

	# Calculate the length of the provided parameter.
	my $len = scalar(@arr);

	# If the length is what we are looking for, simply add the list.
	if ($len == $choose) {
		push(@combs, join(',', @arr));
	} elsif ($choose == 1) {
		# Iterate over all the elements in the list.
		for my $e (@arr) {
			# Add each element individually.
			push(@combs, $e);
		}
	} else {
		# Iterate over all the elements in the list.
		for my $i (0 .. $len - 1) {
			# Create a copy of the list.
			my @a = @arr;

			# Pull a single element out.
			my $x = splice(@a, $i, 1);

			# Chop off up to the index.
			splice(@a, 0, $i);

			# Retrieve all the combinations for the rest of the list.
			my @subarr = generate_combinations_from_list($choose - 1, @a);

			# Add the pulled-out character to the beginning of all the
			# sub-elements.
			foreach my $s (@subarr) {
				push(@combs, $x . "," . $s);
			}
		}
	}

	# Return all the identified combinations.
	return @combs;
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

# This is used to find all the permutations.
sub get_permutation_count {
	# Get the parameters.
	my ($target, @possible) = @_;

	# This will hold the number of identified permutations.
	my $perms = 0;

	# Nothing to do if nothing is possible.
	return 0 if (scalar(@possible) == 0 || $target == 0);

	# Pull the first element from the list.
	my $first = shift @possible;

	# How many times does the first element fit into the target?
	$div = int($target / $first);

	# If it is evenly divisible, add one to the perms.
	$perms++ if ($div * $first == $target);

	# Iterate through adding the first element.
	for $i (0 .. $div) {
		# Get the new target value.
		$new_target = $target - ($i * $first);

		# Get the possible permutations for the rest of the list.
		$perms += get_permutation_count($new_target, @possible);
	}

	# Return the identified number of permutations.
	return $perms;
}


# This is used to find a factorial.
sub fact {
	# Get the parameter.
	my $n = shift;

	# Start with the product.
	my $product = $n;

	# Iterate through the available n values.
	while ($n-- > 1) {
		# Update the product.
		$product *= $n;
	}

	# Return the identified product.
	return $product;
}


# This is used to reduce a fraction.
sub reduce_fraction {
	# Get the fraction to reduce.
	my @f = @_;

	# Get the greatest common factor.
	my $gcf = get_gcf($f[0], $f[1]);

	# No change to the fraction.
	return @f if $gcf == 1;

	# Update the fraction values.
	$f[0] /= $gcf;
	$f[1] /= $gcf;

	# Reduce again.
	return reduce_fraction(@f);
}

# This is used to retrieve the greatest common factor of two numbers.
sub get_gcf {
	# Get the parameters.
	my ($n, $d) = @_;

	# Determine which is higher.
	my $h = ($n > $d) ? $n : $d;
	my $l = ($n > $d) ? $d : $n;

	# Check to see if l is a divisor of h.
	my $d = $h / $l;
	return $l if ($d == int($d));

	# Iterate through potential divisors of l.
	for $t (2 .. int($l/2)) {
		# Divide l by t.
		$d = $l / $t;

		# Move on if l is not a multiple of d.
		next if ($d != int($d));

		# Check to see if n is a multiple of d.
		$t = $n / $d;

		# Return d if it is a common factor of n also.
		return $d if ($t == int($t));
	}

	# Could not find a gcf, so return 1.
	return 1;
}

