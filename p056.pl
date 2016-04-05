
#
# Problem 56:
#
# A googol (10**100) is a massive number: one followed by one-hundred zeros;
# 100**100 is almost unimaginably large: one followed by two-hundred zeros.
# Despite their size, the sum of the digits in each number is only 1.
# 
# Considering natural numbers of the form, a**b, where a, b < 100, what is the
# maximum digital sum?
#

# Include the BigInt library.
use Math::BigInt;

# This is the maximum value for a and b.
$max = 99;

# This is used to keep track of the maximum sum.
$max_sum = 0;

# Iterate a over the range.
for my $a (2 .. $max) {
	# Iterate b over the range.
	for my $b (1 .. $max) {
		# Create a BigInt version of A.
		my $big_a = Math::BigInt->new($a);

		# Raise to the requested power.
		my $pow = $big_a->bpow($b);

		# Retrieve the sum of the digits.
		my $s = get_digit_sum($pow);

		# Update the max sum if necessary.
		$max_sum = $s if ($s > $max_sum);
	}
}

# Print the result.
print "Found: $max_sum\n";

# This is used to get the sum of the digits.
sub get_digit_sum {
	# Get the parameter.
	my $n = shift;

	# Chop the leading '+' off the front.
	$n =~ s/^\+//;

	# Build an expression, evaluate it, and return the result.
	return eval(join('+', split(//, $n)));
}


