
#
# Problem 5:
#
# 2520 is the smallest number that can be divided by each of the numbers from 1
# to 10 without any remainder.
# 
# What is the smallest number that is evenly divisible by all of the numbers
# from 1 to 20?
#

# This is the max value for the divisors.
$max = 20;

# This is the number that is found.
$val = $max;

# The main loop.
while (true) {
	# Keep track of whether all divisors were okay.
	$all = true;

	# Iterate over the divisors.
	for $d (1 .. $max) {
		# Determine whether it is evenly divisible.
		$all = false and last if ($val % $d != 0);
	}

	# Determine if it was found.
	last if ($all eq true);

	# Move to the next possible number.
	$val += $max;
}

# Found it.
print "Found $val\n";

