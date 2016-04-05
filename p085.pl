
#
# Problem 85:
#
# By counting carefully it can be seen that a rectangular grid measuring 3 by 2
# contains eighteen rectangles.
# 
# Although there exists no rectangular grid that contains exactly two million
# rectangles, find the area of the grid with the nearest solution.
#

# This will keep track of the minimum difference.
$min_diff = undef;

# This will hold the minimum area found.
$area = undef;

# This is our starting value.
$r = 0;

# Iterate until we get too high.
while (++$r) {
	# Calculate the triangle number for r.
	$rn = $r * ($r + 1) / 2;

	# Break out if we get too high.
	last if $rn > 2000000;

	# Reset the c value.
	$c = 0;

	# Iterate until we get too high.
	while (++$c) {
		# Find the triangle number for c.
		$cn = $c * ($c + 1) / 2;

		# Find the product of the two triangle numbers.
		$tn = $rn * $cn;

		# Update the minimum values if necessary.
		$min_diff = abs(2000000 - $tn) and $area = $r * $c
			if ($min_diff eq undef || abs(2000000 - $tn) < $min_diff);

		# Break out if we get too high.
		last if $tn > 2000000;
	}
}

# Print the result.
print "Found: $area\n";

