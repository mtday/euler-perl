
#
# Problem 40:
#
# An irrational decimal fraction is created by concatenating the positive
# integers:
# 
#        0.123456789101112131415161718192021...
# 
# It can be seen that the 12th digit of the fractional part is 1.
# 
# If dn represents the nth digit of the fractional part, find the value of the
# following expression.
# 
# d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000
#

# This will hold the list of numbers.
@list = ( 0 );
$len = 0;

# Build the list.
for ($i = 1; $len < 1000000; $i++) {
	push(@list, $i) and $len += length($i);
}

# Build the array full of individual digits.
@d = split(//, join('', @list));

# Print the result.
print "Answer: " . ($d[1] * $d[10] * $d[100] * $d[1000] * $d[10000] * $d[100000] * $d[1000000]) . "\n";

