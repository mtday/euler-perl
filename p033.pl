
#
# Problem 33:
#
# The fraction 49/98 is a curious fraction, as an inexperienced mathematician
# in attempting to simplify it may incorrectly believe that 49/98 = 4/8, which
# is correct, is obtained by cancelling the 9s.
# 
# We shall consider fractions like, 30/50 = 3/5, to be trivial examples.
# 
# There are exactly four non-trivial examples of this type of fraction, less
# than one in value, and containing two digits in the numerator and
# denominator.
# 
# If the product of these four fractions is given in its lowest common terms,
# find the value of the denominator.
#

# Define the range of the numerator and denominator.
$low = 10;
$high = 99;

# This will hold the product.
$prod = 1;

# Iterate over the possible values, keeping the n < d.
for $n ($low .. $high - 1) {
	for $d ($n + 1 .. $high) {
		# Find the product.
		$val = $n / $d;

		# Generate the predicted fraction.
		$n2 = substr("$n", 0, 1);
		$d2 = substr("$d", 1, 2);

		# Skip if it does not meet the pattern.
		next if (substr("$n", 1, 2) ne substr("$d", 0, 1));

		# Skip since we cannot divide by 0.
		next if ($d2 == 0);

		# Find the real answer.
		$val2 = $n2 / $d2;

		# Update the product if necessary.
		$prod *= $val if ($val == $val2);
	}
}

# Print the product.
print "Product: $prod\n";
print "  Answer is the denominator.";

