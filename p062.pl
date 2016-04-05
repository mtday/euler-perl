
#
# Problem 62:
#
# The cube, 41063625 (345**3), can be permuted to produce two other cubes:
# 56623104 (384**3) and 66430125 (405**3). In fact, 41063625 is the smallest
# cube which has exactly three permutations of its digits which are also cube.
# 
# Find the smallest cube for which exactly five permutations of its digits are
# cube.
#

# The number of permutations to look for.
$perms = 5;

# This will hold the identified cubes.
%c = ( );

# This is the starting value.
$n = 0;

# Iterate continually.
while (++$n) {
	# Get the cubed value.
	my $ncubed = $n * $n * $n;

	# Get the sorted digits.
	my $digs = join('', sort(split(//, $ncubed)));

	# Add this value to the hash.
	$c{$digs} = exists($c{$digs}) ? "$c{$digs},$n" : $n;

	# Get the new value.
	my $val = $c{$digs};

	# Get rid of the digits.
	$val =~ s/\d//g;

	# Check to see if it is long enough.
	if (length($val) == $perms - 1) {
		# Get the individual numbers.
		my @nums = split(/,/, $c{$digs});

		# Print the result and exit the loop.
		print "Found: " . ($nums[0] * $nums[0] * $nums[0]) . "\n" and last;
	}
}

