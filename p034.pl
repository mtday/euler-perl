
#
# Problem 34:
#
# 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
# 
# Find the sum of all numbers which are equal to the sum of the factorial of
# their digits.
# 
# Note: as 1! = 1 and 2! = 2 are not sums they are not included.
#

# 2 - 2
# 3 - 6
# 4 - 24
# 5 - 120
# 6 - 720
# 7 - 5040
# 8 - 40320
# 9 - 362880

# This is the maximum value to go to.
$min = 3;
$max = 50000;

# This array will hold our factorial values so we don't have to calculate
# them every time.
@f = ( 1, 1 );
push(@f, $f[$#f] * ($#f+1)) while ($#f < 9);

# This will hold the total sum.
$total = 0;

# Iterate over all the values.
for $n ($min .. $max) {
	# This will hold the sum.
	$sum = 0;

	# Iterate over each digit in the number.
	foreach (split(//, "$n")) {
		# Add the factorial to the sum.
		$sum += $f[$_];

		# Break out if we go too high.
		last if ($sum > $n);
	}

	# Print when we find one.
	$total += $n and print "Found $n\n" if ($n == $sum);
}

# Print the answer.
print "Total Sum: $total\n";

