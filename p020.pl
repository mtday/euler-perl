
#
# Problem 20:
#
# n! means n × (n - 1) × ... × 3 × 2 × 1
# 
# Find the sum of the digits in the number 100!
#

use Math::BigInt;

# The factorial to find.
$n = 100;

# This holds the factorial.
$fact = Math::BigInt->new($n);

# Find the factorial value.
$fact *= $n while ($n-- > 1);

# Print the sum of the digits.
print "Sum: " . eval(join('+', split(//, substr($fact, 1)))) . "\n";

