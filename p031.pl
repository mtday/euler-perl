
#
# Problem 31:
#
# In England the currency is made up of pound, £, and pence, p, and there are
# eight coins in general circulation:
# 
# 	1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
# 
# It is possible to make £2 in the following way:
# 
# 	1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
# 
# How many different ways can £2 be made using any number of coins?
#

# This is the list of available values.
@list = (200, 100, 50, 20, 10, 5, 2, 1);

# This is the target value.
$target = 200;

# Find and print the number of permutations.
print "Found: " . get_permutation_count($target, @list) . "\n";

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

