
#
# Problem 16:
#
# 2**15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
# 
# What is the sum of the digits of the number 2**1000?
#

use Math::BigInt;

# This is the exponent we are aiming for.
$exp = 1000;

# Find the value of 2 to the $exp.
$val = Math::BigInt->new(2)->bpow($exp);

# Print the sum of the digits.
print "Sum: " . eval(join('+', split(//, substr($val, 1)))) . "\n";

