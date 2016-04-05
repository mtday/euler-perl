
#
# Problem 6:
#
# The sum of the squares of the first ten natural numbers is,
# 1^2 + 2^2 + ... + 10^2 = 385
# 
# The square of the sum of the first ten natural numbers is,
# (1 + 2 + ... + 10)^2 = 55^2 = 3025
# 
# Hence the difference between the sum of the squares of the first ten natural
# numbers and the square of the sum is 3025 - 385 = 2640.
# 
# Find the difference between the sum of the squares of the first one hundred
# natural numbers and the square of the sum.
#

# The max number in the range.
$max = 10;

# n**3/3 + n**2/2 + n/6
$sum_sqr = ($max ** 3)/3 + ($max ** 2)/2 + $max/6;

# n * (n-1) / 2
$sqr_sum = (($max + 1) * ($max) / 2) ** 2;

print "Square of the Sum:  $sqr_sum\n";
print "Sum of the Squares: $sum_sqr\n";
print "Difference:         " . ($sqr_sum - $sum_sqr) . "\n";

