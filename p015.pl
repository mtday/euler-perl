
#
# Problem 15:
#
# Starting in the top left corner of a 2×2 grid, there are 6 routes (without
# backtracking) to the bottom right corner.
# 
# How many routes are there through a 20×20 grid?
#

# This is the size of the grid.
$n = 20;

# This is the number of paths found.
$paths = fact(2 * $n) / (fact($n) * fact($n));

# This is used to find a factorial.
sub fact {
	my $n = shift;
	my $product = $n;

	# Iterate through the available n values.
	while ($n-- > 1) {
		$product *= $n;
	}

	# Return the identified product.
	return $product;
}

# Print the answer.
print "Found: $paths\n";

