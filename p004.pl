
#
# Problem 4:
#
# A palindromic number reads the same both ways. The largest palindrome made
# from the product of two 2-digit numbers is 9009 = 91 × 99.
#
# Find the largest palindrome made from the product of two 3-digit numbers.
#

# This is the maximum value.
$max = 999;

# This is the minimum value.
$min = 100;

# This is the maximum palindrome found.
$maxpal = 0;

# Perform the iterations.
for $a ($min..$max) {
	for $b ($min..$max) {
		# Determine the product.
		$prod = $a * $b;

		# Determine whether this is a palindrome.
		$pal = "$prod" eq reverse("$prod");

		# Set the new max if necessary.
		$maxpal = $prod if ($pal and $maxpal < $prod);
	}
}

# Print the identified palindromes.
print "Found: $maxpal\n";

