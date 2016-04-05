
#
# Problem 38:
#
# Take the number 192 and multiply it by each of 1, 2, and 3:
# 
# 	192 × 1 = 192
# 	192 × 2 = 384
# 	192 × 3 = 576
# 
# By concatenating each product we get the 1 to 9 pandigital, 192384576. We
# will call 192384576 the concatenated product of 192 and (1,2,3)
# 
# The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4,
# and 5, giving the pandigital, 918273645, which is the concatenated product of
# 9 and (1,2,3,4,5).
# 
# What is the largest 1 to 9 pandigital 9-digit number that can be formed as
# the concatenated product of an integer with (1,2, ... , n) where n > 1?
#


# The maximum possible value (2 5-digit numbers is too much).
$max = 10000;

# This is used to keep track of the highest one found.
$found = 0;

# Iterate over all the numbers to test.
for my $t (2 .. $max) {
	# This is the concatenated number.
	my $num = "$t";

	# This is the starting n.
	my $n = 1;

	# Iterate while the number is not 9 digits.
	while (length($num) < 9) {
		# Concatenate the next multiplication.
		$num = $num . ($t * ++$n);
	}

	# Check to see if the number is pandigital.
	$found = $num if (is_pandigital($num) eq true && $num > $found);
}

# Print the answer.
print "Found $found\n";

# Determine if a number is pandigital.
sub is_pandigital {
	# Get the parameter.
	my $p = shift;

	# Return the result.
	return ("123456789" eq join('', sort(split(//, $p)))) ? true : false;
}

