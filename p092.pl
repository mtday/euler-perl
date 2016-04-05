
#
# Problem 92:
#
# A number chain is created by continuously adding the square of the digits in
# a number to form a new number until it has been seen before.
# 
# For example,
# 
# 44 -> 32 -> 13 -> 10 -> 1 -> 1
# 85 -> 89 -> 145 -> 42 -> 20 -> 4 -> 16 -> 37 -> 58 -> 89
# 
# Therefore any chain that arrives at 1 or 89 will become stuck in an endless
# loop. What is most amazing is that EVERY starting number will eventually
# arrive at 1 or 89.
# 
# How many starting numbers below ten million will arrive at 89?
#

# The maximum value.
$max = 10000000;

# This is the starting number minus one.
$n = 1;

# This will keep track of the count.
$count = 0;

# Iterate until we hit the max.
while (++$n < $max) {
	# This number will be iterated.
	$i = $n;

	# Iterate until we hit 1 or 89.
	while ($i != 1 && $i != 89) {
		# This will hold the next i.
		$sum = 0;

		# Calculate the sum of the square of each digit.
		$sum += ($_ * $_) for (split(//, $i));

		# Update the value.
		$i = $sum;
	}

	# Increment the counter if necessary.
	$count++ if ($i == 89);
}

# Print the result.
print "Found: $count\n";

