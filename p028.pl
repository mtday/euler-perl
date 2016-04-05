
#
# Problem 28:
#
# Starting with the number 1 and moving to the right in a clockwise direction a
# 5 by 5 spiral is formed as follows:
# 
#                 21 22 23 24 25
#                 20  7  8  9 10
#                 19  6  1  2 11
#                 18  5  4  3 12
#                 17 16 15 14 13
# 
# It can be verified that the sum of both diagonals is 101.
# 
# What is the sum of both diagonals in a 1001 by 1001 spiral formed in the same
# way?
#

# This is the size of the spiral.
$size = 1001;

# This is the starting value.
$n = $size * $size;

# Start with the maximum value ($size * $size).
$sum = $n;

# Iterate over each grid size.
for ($s = $size; $s >= 3; $s -= 2) {
	# Iterate over the last three corners in this grid, and the first
	# (top-right) corner of the next grid.
	foreach (1 .. 4) {
		# Calculate the value of this corner.
		$n -= $s - 1;

		# Add this corner.
		$sum += $n;
	}
}

# Print the answer.
print "Found: $sum\n";

