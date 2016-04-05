
#
# Problem 26:
#
# A unit fraction contains 1 in the numerator. The decimal representation of
# the unit fractions with denominators 2 to 10 are given:
# 
# 	1/2	= 	0.5
# 	1/3	= 	0.(3)
# 	1/4	= 	0.25
# 	1/5	= 	0.2
# 	1/6	= 	0.1(6)
# 	1/7	= 	0.(142857)
# 	1/8	= 	0.125
# 	1/9	= 	0.(1)
# 	1/10	= 	0.1
# 
# Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be
# seen that 1/7 has a 6-digit recurring cycle.
# 
# Find the value of d < 1000 for which 1/d contains the longest recurring cycle
# in its decimal fraction part.
#

use Math::BigFloat;

# The maximum denominator.
$max_denom = 1000;

# The maximum cycle length found.
$max_cycle_len = 0;

# The denominator with the longest cycle.
$denom = 0;

# This is the number of matching characters to find.
$chars = 12;

# Number of places after the decimal.
$precision = 4000;

# Iterate through all the fractions.
for $d (2 .. $max_denom) {
	# Create the fraction.
	$frac = Math::BigFloat->new(1);
	$frac->precision(- $precision);
	$frac->bdiv($d);

	# Get rid of everything in front of the decimal and the rounded digit.
	$frac =~ s/.*\.(\d+)\d/\1/;

	# Get rid of all the trailing zeros.
	$frac =~ s/([1-9]*)0+/\1/;

	# Don't worry about non-repeating numbers.
	next if (length($frac) < $precision - $chars);

	# Get the last three digits.
	$substr = substr($frac, length($frac)-$chars, $chars);

	# Find the previous location of the three digits.
	$rindex = rindex($frac, $substr, length($frac)-$chars-1);

	# Make sure it was found.
	next if ($rindex < 0);

	# The difference is the cycle length.
	$clen = length($frac) - $rindex - $chars;

	# Set the new maximum if necessary.
	$max_cycle_len = $clen and $denom = $d if ($clen > $max_cycle_len);
}

# Print the message.
print "Found: $denom (cycle length: $max_cycle_len)\n";

