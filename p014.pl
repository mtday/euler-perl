
#
# Problem 14:
#
# The following iterative sequence is defined for the set of positive integers:
# 
# n -> n/2 (n is even)
# n -> 3n + 1 (n is odd)
# 
# Using the rule above and starting with 13, we generate the following
# sequence:
#     13 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1
# 
# It can be seen that this sequence (starting at 13 and finishing at 1)
# contains 10 terms. Although it has not been proved yet (Collatz Problem), it
# is thought that all starting numbers finish at 1.
# 
# Which starting number, under one million, produces the longest chain?
# 
# NOTE: Once the chain starts the terms are allowed to go above one million.
#

# This is the last number.
$last = 1000000;

# This keeps track of the max chain we have seen so far.
$max_chain_len = 0;

# This keeps track of the number that caused the longest chain.
$max_chain_num = 0;

# Iterate over all the numbers.
for $num (1 .. $last) {
	# Keep track of the chain length for this number.
	$chain_len = 1;

	# This number will move through the iterations.
	$n = $num;

	# Iterate through even and odd numbers until we hit 1.
	while ($n != 1) {
		# Increment the chain length.
		$chain_len++;

		# Change the number.
		$n = ($n % 2 == 0) ? ($n / 2) : ($n * 3 + 1);
	}

	# Update the maximum if necessary.
	$max_chain_len = $chain_len and $max_chain_num = $num
		and print "$num: $chain_len\n"
		if ($chain_len > $max_chain_len);
}

# Print the result.
print "Found $max_chain_num, with a chain length of $max_chain_len\n";

