
#
# Problem 32:
#
# The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing
# multiplicand, multiplier, and product is 1 through 9 pandigital.
# 
# Find the sum of all products whose multiplicand/multiplier/product identity
# can be written as a 1 through 9 pandigital.
#
# HINT: Some products can be obtained in more than one way so be sure to only
# include it once in your sum.
#

# This is the maximum value of a and b.
$max = 2000;

# This is the sorted pattern we are looking for.
$str = '123456789';

# This will hold all the products.
%hash = ( );

# Iterate up to max with a and b, keeping b > a.
for $a (1 .. $max - 1) {
	for $b ($a + 1 .. $max) {
		# Find the product.
		$p = $a * $b;

		# Sort all the digits as a string.
		$s = join('', sort(split(//, join('', ($a, $b, $p)))));

		# Break out of the loop early if we go too high.
		last if (length($s) > 9);

		# Sum if all the digits are there.
		$hash{$p} = 1 if ($str eq $s);
	}
}

# Find the sum of all the keys in the hash.
$sum = 0; $sum += $_ for (keys %hash);

# Print the result.
print "Found: $sum\n";

