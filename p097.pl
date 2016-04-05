
#
# Problem 97:
#
# The first known prime found to exceed one million digits was discovered in
# 1999, and is a Mersenne prime of the form (2**6972593)-1; it contains exactly
# 2,098,960 digits. Subsequently other Mersenne primes, of the form (2**p)-1,
# have been found which contain more digits.
# 
# However, in 2004 there was found a massive non-Mersenne prime which contains
# 2,357,207 digits: (28433 * 2**7830457)+1.
# 
# Find the last ten digits of this prime number.
#

# Include the BigInt library.
use Math::BigInt;

# Note that digits repeat in this fashion:
#   10:   4 digits repeat
#    9:   20 digits repeat
#    8:   100 digits repeat
#    7:   500 digits repeat
#    6:   2500 digits repeat
#    5:   12500 digits repeat
#    4:   62500 digits repeat
#    3:   312500 digits repeat
#    2:   1562500 digits repeat
#    1:   7812500 digits repeat
#
# Since each of these are multiples of each other, (28433 * 2**7830457)+1
# will have the same last 10 digits as (28433 * 2**(7830457%7812500))+1.

# This is the exponent we are looking for.
$exp = 7830457;

# These are the BigInt objects we use.
$two = Math::BigInt->new(2);
$mul = Math::BigInt->new(28433);

# Calculate the value.
$val = ($mul * ($two->bpow($exp % 7812500)) + 1);

# Print the last 10 digits.
print "Found: " . substr($val, length($val)-10, 10) . "\n";

