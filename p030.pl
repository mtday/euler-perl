
#
# Problem 30:
#
# Surprisingly there are only three numbers that can be written as the sum of
# fourth powers of their digits:
# 
# 	1634 = 1**4 + 6**4 + 3**4 + 4**4
# 	8208 = 8**4 + 2**4 + 0**4 + 8**4
# 	9474 = 9**4 + 4**4 + 7**4 + 4**4
# 
#           As 1 = 1**4 is not a sum it is not included.
# 
# The sum of these numbers is 1634 + 8208 + 9474 = 19316.
# 
# Find the sum of all the numbers that can be written as the sum of fifth
# powers of their digits.
#

# This is the power we are looking for.
$pow = 5;

# This is the likely maximum value.
$max = ($pow + 1) * (9 ** $pow);

# This is the sum of all the identified values.
$sum = 0;

# Iterate over the range of values.
for $n (2 .. $max) {
	# Calculate the sum of the powers for the digits.
	$val = eval(join("**$pow + ", split(//, $n)) . "**$pow");

	# Add the value to the sum if necessary.
	$sum += $n if ($val == $n);
}

# Print the result.
print "Sum: $sum\n";

