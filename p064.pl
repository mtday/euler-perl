
#
# Problem 64:
#
# All square roots are periodic when written as continued fractions.
# 
# The first ten continued fraction representations of (irrational) square roots
# are:
# 
#           v2=[1;(2)], period=1
#           v3=[1;(1,2)], period=2
#           v5=[2;(4)], period=1
#           v6=[2;(2,4)], period=2
#           v7=[2;(1,1,1,4)], period=4
#           v8=[2;(1,4)], period=2
#           v10=[3;(6)], period=1
#           v11=[3;(3,6)], period=2
#           v12= [3;(2,6)], period=2
#           v13=[3;(1,1,1,1,6)], period=5
# 
# Exactly four continued fractions, for N = 13, have an odd period.
# 
# How many continued fractions for N = 10000 have an odd period?
#

# This is the maximum value.
$max = 10000;

# This is the count.
$count = 0;

# This is the starting value minus 1.
$n = 1;

while ($n++ < $max) {
	# The starting values.
	$m = 0;
	$d = 1;
	$a = int(sqrt($n));

	# Don't do perfect squares.
	next if ($a * $a == $n);

	# This is the initial sequence value.
	$init = $a;

	# This holds the repeating numbers.
	@rep = ( );

	# Iterate through all the repeating numbers.
	while ($init * 2 != $a) {
		# Update the variables.
		$m = ($d * $a) - $m;
		$d = ($n - ($m * $m)) / $d;
		$a = int((sqrt($n) + $m) / $d);

		# Add the new number to the list.
		push(@rep, $a);
	}

	# Update the counter if necessary.
	$count++ if (scalar(@rep) % 2 == 1);
}

# Print the result.
print "Found: $count\n";

