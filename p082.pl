
#
# Problem 82:
#
# NOTE: This problem is a more challenging version of Problem 81.
# 
# The minimal path sum in the 5 by 5 matrix below, by starting in any cell in
# the left column and finishing in any cell in the right column, and only
# moving up, down, and right, is indicated in red; the sum is equal to 994.
# 
# 	
#                 131 673  234  103   18
#                 201  96  342  965  150
#                 630 803  746  422  111
#                 537 699  497  121  956
#                 805 732  524   37  331

# 
# Find the minimal path sum, in matrix.txt (right click and 'Save Link/Target
# As...'), a 31K text file containing a 80 by 80 matrix, from the left column
# to the right column.
#

# This is the data file containing the numbers.
$data_file = "p082.txt";

# Open the data file.
open(FILE, $data_file) || die("Could not open file.");

# Pull all the numbers from the file.
push(@nums, split(/,/, $num)) while ($num = <FILE> and chop($num));

# Close the file.
close(FILE);

# Determine the size of the grid.
$size = sqrt(scalar(@nums));

# Iterate over the columns.
for $c (1 .. $size-2) {
	# This will hold the new values for this column.
	@new_vals = ( );

	# Iterate over the rows.
	for $r (0 .. $size-1) {
		# This will hold the possible values to replace the number
		# in this cell.
		@possible = ( );

		# Get the sum of this cell and the cell to the left, and
		# add it to the list of possible values.
		push(@possible, $nums[$r*$size+$c] + $nums[$r*$size+$c-1]);

		# Iterate over the rows again.
		for $r2 (0 .. $size-1) {
			# Skip this row if we are currently processing it.
			next if $r2 == $r;

			# Start with the value to the left.
			$sum = $nums[$r2*$size+$c-1];

			while ($r2 != $r) {
				# Add this cells value.
				$sum += $nums[$r2*$size+$c];

				# Move the r2 value toward r.
				$r2 += ($r2 > $r) ? -1 : 1;
			}

			# Add the r cell value.
			$sum += $nums[$r2*$size+$c];

			# Add this possible value to the list.
			push(@possible, $sum);
		}

		# Sort the possible values.
		@possible = sort { $a <=> $b } @possible;

		# Add the lowest possible value to the list of new values.
		push(@new_vals, $possible[0]);
	}

	# Replace all the values in this column.
	$nums[$_*$size+$c] = $new_vals[$_] foreach (0 .. $size-1);
}

# This will hold the minimum value.
$min = undef;

# Iterate to find the smallest value.
for $r (0 .. $size-1) {
	# Get the sum of the right most column and the column to its left.
	$sum = $nums[$r*$size+$size-1] + $nums[$r*$size+$size-2];

	# Update the minimum value if necessary.
	$min = $sum if ($min eq undef || $min > $sum);
}

# Print the result.
print "Found: $min\n";

