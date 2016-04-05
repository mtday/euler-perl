
#
# Problem 21:
#
# Let d(n) be defined as the sum of proper divisors of n (numbers less than n
# which divide evenly into n).  If d(a) = b and d(b) = a, where a != b, then a
# and b are an amicable pair and each of a and b are called amicable numbers.
# 
# For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44,
# 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4,
# 71 and 142; so d(284) = 220.
# 
# Evaluate the sum of all the amicable numbers under 10000.
#

# This is the top of the range.
$top = 10000 - 1;

# This will keep track of the sum.
$sum = 0;

# Iterate over the range.
for $a (2 .. $top) {
	# Calculate d(a).
	$da = d($a);

	# Calculate d(d(a)).
	$dda = d($da);

	# Update the sum if the numbers are amicable.
	$sum += $a if ($a == $dda && $a != $da);
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

# Print the result.
print "Sum: $sum\n";

