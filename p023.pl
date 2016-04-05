
#
# Problem 23:
#
# A perfect number is a number for which the sum of its proper divisors is
# exactly equal to the number. For example, the sum of the proper divisors of
# 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
# 
# A number whose proper divisors are less than the number is called deficient
# and a number whose proper divisors exceed the number is called abundant.
# 
# As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest
# number that can be written as the sum of two abundant numbers is 24. By
# mathematical analysis, it can be shown that all integers greater than 28123
# can be written as the sum of two abundant numbers. However, this upper limit
# cannot be reduced any further by analysis even though it is known that the
# greatest number that cannot be expressed as the sum of two abundant numbers
# is less than this limit.
# 
# Find the sum of all the positive integers which cannot be written as the sum
# of two abundant numbers.
#

# This is the maximum value.
$max = 28123;

# This will hold the list of abundant numbers.
@an = ( );

# Iterate to find all the abundant numbers.
for $n (12 .. $max) {
	# Find the sum of the divisors for this number.
	$sum_div = d($n);

	# Add the abundant numbers to the list.
	push(@an, $n) if ($sum_div > $n);
}

# This hash will hold the abundant number summations.
%anh = ( );

# Add all the values to the hash.
for $a (@an) {
	for $b (@an) {
		next if ($b < $a || $a + $b > $max);
		$anh[$a+$b] = "$a:$b";
	}
}

# This will hold the sum we are looking for.
$sum = 12 * 13 / 2;

# Iterate to find the sum (starting at 13).
for $n (13 .. $max) {
	# Skip numbers that appear as sums in the hash.
	next if ($anh[$n] != undef);

	# Add this number to the sum if necessary.
	$sum += $n;
	$last2 = $last;
	$last = $n;
}

# Used to calculate the sum of divisors for the given parameter.
sub d {
	# Get the parameter.
	my $n = shift;

	# Determine how far we should go when checking divisors.
	my $top = int(sqrt($n));

	# This will keep track of the sum of divisors.
	my $div_sum = 1;

	# Iterate over all the potential divisors.
	for $d (2 .. $top) {
		# Increase the divisor sum if d is a divisor.
		if ($n % $d == 0) {
			if ($d * $d == $n) {
				# Add the square root to the sum.
				$div_sum += $top;
			} else {
				# Add the divisor and quotient.
				$div_sum += $d + ($n / $d);
			}
		}
	}

	# Return the identified sum.
	return $div_sum;
}

# Print the identified sum.
print "Sum: $sum\n";

