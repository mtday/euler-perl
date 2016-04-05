
#
# Problem 104:
#
# The Fibonacci sequence is defined by the recurrence relation:
# 
# 	Fn = Fn-1 + Fn-2, where F1 = 1 and F2 = 1.
# 
# It turns out that F541, which contains 113 digits, is the first Fibonacci
# number for which the last nine digits are 1-9 pandigital (contain all the
# digits 1 to 9, but not necessarily in order). And F2749, which contains 575
# digits, is the first Fibonacci number for which the first nine digits are 1-9
# pandigital.
# 
# Given that Fk is the first Fibonacci number for which the first nine digits
# AND the last nine digits are 1-9 pandigital, find k.
#

# Include the BigInt library.
use Math::BigInt;

# This is the starting value.
$n = 2;

# These are the initial previous values.
$p1 = $p2 = Math::BigInt->new(1);

# Iterate until we are done.
while (++$n) {
	# Get the sum of the two previous values.
	my $s = $p1 + $p2;

	print "F$n\n" if ($n % 1000 == 0);

	# Update the values.
	$p1 = $p2;
	$p2 = $s;

	# Get the length of the number.
	$len = length($s);

	# Make sure the number is long enough.
	next if $n < 170000 || $len < 17;

	# Get first and last 9 digits.
	my $first9 = substr($s, 0, 9);
	my $last9 = substr($s, $len - 9, 9);

	# Check to see if the first and last 9 are pandigital.
	next if "123456789" ne join('', sort(split(//, $first9)));
	next if "123456789" ne join('', sort(split(//, $last9)));

	# If we made it here, we found the answer.
	print "Found: $n\n" and last;
}

# > 170K

