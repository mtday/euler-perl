
#
# Problem 60:
#
# The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes
# and concatenating them in any order the result will always be prime. For
# example, taking 7 and 109, both 7109 and 1097 are prime. The sum of these
# four primes, 792, represents the lowest sum for a set of four primes with
# this property.
# 
# Find the lowest sum for a set of five primes for which any two primes
# concatenate to produce another prime.
#

# This is the size of the set of numbers.
$set_size = 5;

# This keeps track of the smallest sum found.
$min = undef;

# These are the primes found so far.
@primes = ( 2, 3 );

# This is the hash of prime pairs.
%pairs = ( );

# This is the starting value.
$n = 3;

# This is the starting value.
while ($n += 2) {
	# Continue if this value is not prime.
	next if (!is_prime($n));

	# Keep track of the pairs we find with this number.
	@pair_list = ( );

	# This is the starting value.
	foreach my $p (@primes) {
		# Get the two pairs for this prime.
		$pair1 = "$p$n";
		$pair2 = "$n$p";

		# Continue on if either of these is not prime.
		next if (!is_prime($pair1) || !is_prime($pair2));

		# Add the hash values.
		$pairs{$p} = exists($pairs{$p}) ? "$pairs{$p},$n" : $n;
		$pairs{$n} = exists($pairs{$n}) ? "$pairs{$n},$p" : $p;

		# Add this pair to the list.
		push(@pair_list, $p);
	}

	# Retrieve the combinations for this list.
	@combs = generate_combinations_from_list($set_size-1, @pair_list);

	# Iterate over all the combinations.
	for $comb (@combs) {
		# Get the parts of this combination.
		@cparts = split(/,/, $comb);

		# Keep track of whether we found a match.
		$match = 1;

		# Iterate over each part.
		for $c1 (@cparts) {
			$str = $pairs{$c1};
			for $c2 (@cparts) {
				next if $c2 == $c1;

				# Check for a match.
				$match = 0 and last if (",$str," !~ /,$c2,/);
			}

			# Stop checking if we don't have a match.
			last if ! $match;
		}

		# Do we have a match?
		if ($match) {
			# Retrieve the sum.
			$sum = eval(join('+', split(/,/, "$comb,$n")));

			# Save the minimum if necessary.
			print "Potential: $sum\n" and $min = $sum
				if ($min eq undef || $sum < $min);
		}
	}

	# Add this number to the list of pairs.
	push(@pair_list, $n);

	# Add this prime to the list.
	push(@primes, $n);

	# Exit out if we cannot beat the minimum.
	last if ($min ne undef && $n > $min);
}

# Print the result.
print "Found: $min\n";


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
			my @a = @arr;
			# Pull a single character.
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

