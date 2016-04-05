
#
# Problem 66:
#
# Consider quadratic Diophantine equations of the form:
# 
# x**2 – Dy**2 = 1
# 
# For example, when D=13, the minimal solution in x is 649**2 – 13×180**2 = 1.
# 
# It can be assumed that there are no solutions in positive integers when D is
# square.
# 
# By finding minimal solutions in x for D = {2, 3, 5, 6, 7}, we obtain the
# following:
# 
#    3**2 – 2×2**2 = 1
#    2**2 – 3×1**2 = 1
#    9**2 – 5×4**2 = 1
#    5**2 – 6×2**2 = 1
#    8**2 – 7×3**2 = 1
# 
# Hence, by considering minimal solutions in x for D = 7, the largest x is
# obtained when D=5.
# 
# Find the value of D <= 1000 in minimal solutions of x for which the largest
# value of x is obtained.
#

use Math::BigInt;

# This is as far as we will go.
$maxD = 1000;

# This is used to track the biggest X values we find.
$maxX = 0;

# This is the saved value of D for the big X value.
$savedD = 0;

# This is the starting value minus 1.
$d = 1;

while (++$d <= $maxD) {
	# The starting values.
	$m = 0;
	$c = 1;
	$a = int(sqrt($d));

	# Don't do perfect squares.
	next if ($a * $a == $d);

	# This is the initial sequence value.
	$init = $a;

	# This holds the repeating numbers.
	@rep = ( );

	# Iterate through all the repeating numbers.
	while ($init * 2 != $a) {
		# Update the variables.
		$m = ($c * $a) - $m;
		$c = ($d - ($m * $m)) / $c;
		$a = int((sqrt($d) + $m) / $c);

		# Add the new number to the list.
		push(@rep, $a);
	}

	# Determine where to truncate the period.
	if (scalar(@rep) % 2 == 1) {
		# Odd period, truncate at the end of the second period.
		push(@rep, @rep);
		pop(@rep);
	} else {
		# Even period, truncate at the end of the first period.
		pop(@rep);
	}

	# Get the numerator and denominator of the continued fraction.
	($x, $y) = get_fraction($init, @rep);

	# Save the highest result.
	$maxX = $x and $savedD = $d if ($x > $maxX);
}

# Print the result.
print "Found: $savedD\n";


# This is used to retrieve the numerator and denominator of a continued
# fraction.
sub get_fraction {
	# Get the addend parameter.
	my $a = shift;

	# Get the period of the repeating fraction.
	my @rep = @_;

	# If there is no period, return the addend by itself (over 1 to make
	# it a fraction).
	return ($a, 1) if (scalar(@rep) == 0);

	# Recursively get the numerator and denominator for the rest of the
	# period (reversing the numerator and denominator).
	my ($d, $n) = get_fraction(shift(@rep), @rep);

	# Convert to an improper fraction and return.
	return ($n + $d * $a, $d);
}

