
#
# Problem 52:
#
# It can be seen that the number, 125874, and its double, 251748, contain
# exactly the same digits, but in a different order.
# 
# Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x,
# contain the same digits.
#

# This is the starting value.
$n = 100;

# Iterate until we find it.
while ($n++) {
	# Get the sorted string representation.
	$ns = join('', sort(split(//, $n)));

	# Calculate 6 * n.
	$n6 = 6 * $n;

	# Check to see if we can skip a bunch of numbers.
	if (length($n6) > length($n)) {
		# Generate the next value.
		$new_n = '1'; $new_n = $new_n . '0' for (1 .. length($n));

		# Set the new value and continue.
		$n = $new_n and next;
	}

	# Compare to 6N to see if wee need to continue.
	next if ($ns ne join('', sort(split(//, $n6))));

	# Compare to 5N to see if wee need to continue.
	next if ($ns ne join('', sort(split(//, 5 * $n))));

	# Compare to 4N to see if wee need to continue.
	next if ($ns ne join('', sort(split(//, 4 * $n))));

	# Compare to 3N to see if wee need to continue.
	next if ($ns ne join('', sort(split(//, 3 * $n))));

	# Compare to 2N to see if wee need to continue.
	next if ($ns ne join('', sort(split(//, 2 * $n))));

	# We found it, so print a message and break out.
	print "Found: $n\n" and last;
}

