
#
# Problem 36:
#
# The decimal number, 585 = 1001001001 (binary), is palindromic in both bases.
# 
# Find the sum of all numbers, less than one million, which are palindromic in
# base 10 and base 2.
# 
# (Please note that the palindromic number, in either base, may not include
# leading zeros.)
#

# The maximum number to go to.
$max = 1000000;

# This is the sum of all palindromic numbers.
$sum = 0;

# Iterate over all the numbers up to the max.
for ($n = 1; $n < $max; $n++) {
	# Determine whether this is a palindrome.
	next if "$n" ne reverse("$n");

	# Get the binary representation of the number.
	$bin = unpack("B32", pack("N", $n));

	# Cut off leading zeros.
	$bin =~ s/^0*//g;

	# Determine whether the binary version is a palindrome.
	next if $bin ne reverse($bin);

	# Both are palindromic, so add it to the sum.
	$sum += $n;
}

# Print the identified sum.
print "Sum: $sum\n";

