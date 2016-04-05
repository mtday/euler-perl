
#
# Problem 48:
#
# The series, 1**1 + 2**2 + 3**3 + ... + 10**10 = 10405071317.
# 
# Find the last ten digits of the series, 1**1 + 2**2 + 3**3 + ... + 1000**1000.
#

# Include the BigInt package.
use Math::BigInt;

# This is the last number in the list.
$last = 1000;

# This will hold the sum.
$sum = Math::BigInt->new(0);

# Iterate up to the last number.
for $n (1 .. $last) {
	# Create a big version of n.
	$bn = Math::BigInt->new($n);

	# Add the value to the sum.
	$sum += $bn->bpow($bn);
}

# Print the last ten digits in the result.
print "Found: " . substr($sum, length($sum)-10, 10) . "\n";
#print "Found: $sum\n";

