
#
# Problem 9:
#
# A Pythagorean triplet is a set of three natural numbers, a < b < c, for
# which, a**2 + b**2 = c**2
# 
# For example, 3**2 + 4**2 = 9 + 16 = 25 = 5**2.
# 
# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.
#

# This is the target sum.
$target = 1000;

# Set the starting values.
$a = 100;
$b = $a + 1;
$c = $target - $a - $b;

# Iterate until we find the solution.
while($a*$a + $b*$b != $c*$c) {
	# Set the B and C values relative to A.
	$b = $a + 1;
	$c = $target - $a - $b;

	# Iterate over all the available B and C values for this A.
	while ($b < $c) {
		# Check to see if we found it.
		if($a*$a + $b*$b == $c*$c) {
			# Print the message out.
			print "Found $a + $b + $c \t= " . ($a + $b + $c) . "\n";
			print "      $a * $b * $c \t= " . ($a * $b * $c) . "\n";
			print "      $a**2 + $b**2\t= " . ($a*$a + $b*$b) . "\n";
			print "      $c**2        \t= " . ($c*$c) . "\n";
			exit;
		}

		# Move to the next iteration of B and C.
		$b++;
		$c--;
	}

	# Move to the next iteration of A.
	$a++;
}

