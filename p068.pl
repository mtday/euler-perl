
#
# Problem 68:
#
# Consider the following "magic" 3-gon ring, filled with the numbers 1 to 6,
# and each line adding to nine.
#
#                          4
#                           \
#                            3
#                           / \
#                          1---2---6
#                         /
#                        5
#
# 
# Working clockwise, and starting from the group of three with the numerically
# lowest external node (4,3,2 in this example), each solution can be described
# uniquely. For example, the above solution can be described by the set: 4,3,2;
# 6,2,1; 5,1,3.
# 
# It is possible to complete the ring with four different totals: 9, 10, 11,
# and 12. There are eight solutions in total.

# Total       Solution Set
#   9        4,2,3; 5,3,1; 6,1,2
#   9        4,3,2; 6,2,1; 5,1,3
#   10       2,3,5; 4,5,1; 6,1,3
#   10       2,5,3; 6,3,1; 4,1,5
#   11       1,4,6; 3,6,2; 5,2,4
#   11       1,6,4; 5,4,2; 3,2,6
#   12       1,5,6; 2,6,4; 3,4,5
#   12       1,6,5; 3,5,4; 2,4,6
#
# 
# By concatenating each group it is possible to form 9-digit strings; the
# maximum string for a 3-gon ring is 432621513.
# 
# Using the numbers 1 to 10, and depending on arrangements, it is possible to
# form 16- and 17-digit strings. What is the maximum 16-digit string for a
# "magic" 5-gon ring?
#

# Find the solution for a 5-gon with digit length 16.
print "Found: " . get_gon_solution(5, 16) . "\n";

# This is used to find a "gon" solution.
sub get_gon_solution {
	# This is the size of the "gon" to find.
	my $gon_size = shift;

	# This is the maximum length of the solution number.
	my $length = shift;

	# This is the list of available numbers.
	push(@nums, $_) for (1 .. $gon_size * 2);

	# Create the string representation of the numbers.
	my $nums_as_str = join('', sort { $a <=> $b } @nums);

	# This is the starting summation value.
	my $sum = $gon_size * 2 + 3;

	# This will hold the identified solutions.
	my @solutions = ( );

	# Iterate until we don't find any more solutions.
	while (true) {
		# Get the "gon" solutions.
		my @combinations = get_target_combinations($sum, 3, @nums);

		# This will hold the combinations based on the middle number.
		my %h = ( );

		# Put all the combinations in the hash.
		foreach my $comb (@combinations) {
			# Get the middle number.
			$m = (split(/,/, $comb))[1];

			# Set the new hash value.
			$h{$m} = (exists($h{$m})) ? $h{$m} . ":" . $comb : $comb;
		}

		# Keep track of whether we found a solution.
		my $solution_found = 0;

		# Iterate over the available combinations.
		foreach my $c (@combinations) {
			# Get the individual values for this combination.
			@cp = split(/,/, $c);

			# This will hold the incremental solutions.
			my @i_sols = ( $c );

			# Iterate while we have incremental solutions available.
			while (scalar(@i_sols) > 0) {
				# Get the current solution.
				$sol = shift @i_sols;

				# Split this solution into it's component parts.
				@sp = split(/,/, $sol);

				# Determine the solution number.
				$sol_num = join('', @sp);

				# Add the solution to the list if it is the right length, and
				# if the middle and last digits line up.
				push(@solutions, $sol_num) and $solution_found = 1
					if (scalar(@sp) == 3 * $gon_size && $sp[$#sp] == $sp[1] &&
							length($sol_num) == $length);

				# Get the next possible values from the hash.
				@vals = split(/:/, $h{$sp[$#sp]});

				# Iterate over the potential new values.
				foreach my $v (@vals) {
					# Split this value into its parts.
					@vp = split(/,/, $v);

					# Make sure the starting value is high enough.
					next if $vp[0] <= $cp[0];

					# Make sure the starting value is unique.
					$uniq = 1;
					foreach $spp (@sp) { $uniq = 0 if $spp == @vp[0]; }
					next if ! $uniq;

					# Add this new incremental solution to the list.
					push(@i_sols, "$sol,$v");
				}
			}
		}

		# Increment the sum we are looking for.
		$sum++;

		# Break out if we don't find any more solutions.
		last if !$solution_found;
	}

	# Get the sorted solutions.
	my @sorted = sort { $a <=> $b } @solutions;

	# Return the last solution.
	return $sorted[$#sorted];
}


# This retrieves number combinations of a specific length that sum to a target
# value.
sub get_target_combinations {
	# Get the parameters.
	my ($target, $length, @nums) = @_;

	# Calculate the length of the provided list.
	my $len = scalar(@nums);

	# This will hold the combinations.
	my @combs = ( );

	# Break out if there is nothing we can add.
	return @combs if ($length == 0 || $target == 0);

	# If we can only add one thing, check the list for the target.
	if ($length == 1) {
		foreach my $num (@nums) {
			push(@combs, $num) and return @combs if ($num == $target);
		}
	}

	# Iterate over all the elements in the list.
	for my $i (0 .. $len - 1) {
		# Create a copy of the list.
		my @a = @nums;

		# Pull a single element out.
		my $x = splice(@a, $i, 1);

		# Break out if this value is too high.
		next if $x > $target;

		# Retrieve all the combinations for the rest of the list.
		my @subarr = get_target_combinations($target - $x, $length - 1, @a);

		# Add the pulled-out character to the beginning of all the
		# sub-elements.
		foreach my $s (@subarr) {
			push(@combs, $x . "," . $s);
		}
	}

	# Return the identified list of combinations.
	return @combs;
}

