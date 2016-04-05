
#
# Problem 81:
#
# In the 5 by 5 matrix below, the minimal path sum from the top left to the
# bottom right, by only moving to the right and down, is indicated in red and
# is equal to 2427.
# 
#  
#           131  673  234  103  18
#           201  96   342  965  150
#           630  803  746  422  111
#           537  699  497  121  956
#           805  732  524  37   331
#  
# 
# Find the minimal path sum, in matrix.txt (right click and 'Save Link/Target
# As...'), a 31K text file containing a 80 by 80 matrix, from the top left to
# the bottom right by only moving right and down.
#

# This is the data file containing the numbers.
$data_file = "p081.txt";

# Open the data file.
open(FILE, $data_file) || die("Could not open file.");

# Pull all the numbers from the file.
push(@nums, split(/,/, $num)) while ($num = <FILE> and chop($num));

# Close the file.
close(FILE);

# Determine the size of the grid.
$size = sqrt(scalar(@nums));

# Do the top left half of the grid.
for my $p (0 .. $size-1) {
	my $r = $p;
	for my $c (0 .. $p) {
		next if $r == 0 && $c == 0;
		# Get the current value.
		my $val = $nums[$r * $size + $c];

		# Get the value above.
		my $above = ($r > 0) ? $nums[($r-1) * $size + $c] : undef;

		# Get the value to the left.
		my $left = ($c > 0) ? $nums[$r * $size + ($c-1)] : undef;

		# Set the new value.
		$max = ($above < $left) ?
			(($above eq undef) ? $left : $above) :
			(($left eq undef) ? $above : $left);
		$nums[$r * $size + $c] = $val + $max;

		# Move on.
		$r--;
	}
}

# Do the bottom right half of the grid.
for $p (1 .. $size-1) {
	$r = $size-1;
	for $c ($p .. $r) {
		# Get the current value.
		my $val = $nums[$r * $size + $c];

		# Get the value above.
		my $above = ($r > 0) ? $nums[($r-1) * $size + $c] : undef;

		# Get the value to the left.
		my $left = ($c > 0) ? $nums[$r * $size + ($c-1)] : undef;

		# Set the new value.
		$max = ($above < $left) ?
			(($above eq undef) ? $left : $above) :
			(($left eq undef) ? $above : $left);
		$nums[$r * $size + $c] = $val + $max;

		# Move on.
		$r--;
	}
}

# Print the result.
print "Found: $nums[$size*$size-1]\n";

