
#
# Problem 1:
#
# If we list all the natural numbers below 10 that are multiples of 3 or 5, we
# get 3, 5, 6 and 9. The sum of these multiples is 23.
# 
# Find the sum of all the multiples of 3 or 5 below 1000.
# 


#------------------------------------------------------------
# Naive approach


# Define the last value of the range, inclusive.
$last = 999;

# This will hold the resulting sum.
$sum = 0;

# Iterate over the range.
for ($i = 1; $i <= $last; $i++) {
	# Determine if the value is a multiple of 3 or 5, and if so, add the value
	# to the sum.
	$sum += $i if ($i % 3 == 0 or $i % 5 == 0);
}

# Print the sum.
print "Sum: $sum\n";



#------------------------------------------------------------
# Math approach


# The number of numbers divisible by 3.
$num3 = int($last / 3);

# The sum of the numbers divisible by 3.
$sum3 = 3 * $num3 * ($num3 + 1) / 2;

# The number of numbers divisible by 5.
$num5 = int($last / 5);

# The sum of the numbers divisible by 5.
$sum5 = 5 * $num5 * ($num5 + 1) / 2;

# The number of numbers divisible by 15.
$num15 = int($last / 15);

# The sum of the numbers divisible by 15.
$sum15 = 15 * $num15 * ($num15 + 1) / 2;

# Determine the sum.
$sum = $sum3 + $sum5 - $sum15;

# Print the sum.
print "Sum: $sum\n";

