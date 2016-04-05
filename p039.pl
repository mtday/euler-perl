
#
# Problem 39:
#
# If p is the perimeter of a right angle triangle with integral length sides,
# {a,b,c}, there are exactly three solutions for p = 120.
# 
#          {20,48,52}, {24,45,51}, {30,40,50}
# 
# For which value of p < 1000, is the number of solutions maximised?
#

# This is the maximum value we are going to.
$max = 1000;

# Keep track of the maximum number of solutions found.
$max_sol = 0;

# Keep track of the p with the maximum number of solutions.
$max_p = 0;

# Iterate up to the maximum value.
for $p (3 .. $max) {
	# Keep track of the number of solutions.
	$sols = 0;

	# Iterate over possible a and b values.
	for $a (1 .. $p / 3) {
		for $b ($a .. $p * 2 / 3) {
			# Calculate the c value.
			$c = $p - $a - $b;

			# Check to see if this is a solution.
			$sols++ if ($a * $a + $b * $b == $c * $c);
		}
	}

	# Update the maximum p value if necessary.
	$max_p = $p and $max_sol = $sols if ($sols > $max_sol);
}

# Print the result.
print "Found $max_p\n";

