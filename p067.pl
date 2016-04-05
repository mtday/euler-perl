
#
# Problem 67:
#
# By starting at the top of the triangle below and moving to adjacent numbers
# on the row below, the maximum total from top to bottom is 23.
# 
#                           3
#                          7 5
#                         2 4 6
#                        8 5 9 3
# 
# That is, 3 + 7 + 4 + 9 = 23.
# 
# Find the maximum total from top to bottom in triangle.txt (right click and
# 'Save Link/Target As...'), a 15K text file containing a triangle with
# one-hundred rows.
# 
# NOTE: This is a much more difficult version of Problem 18. It is not possible
# to try every route to solve this problem, as there are 299 altogether! If you
# could check one trillion (1012) routes every second it would take over twenty
# billion years to check them all. There is an efficient algorithm to solve it.
#

# This is the data file containing the numbers.
$data_file = "p067.txt";

# Open the data file.
open(FILE, $data_file) || die("Could not open file.");

# Create a list of numbers from the file.
@nums = <FILE>;

# Close the file.
close(FILE);

# Create an array containing the bottom row.
@bottom = split(' ', $nums[$#nums]);

# Iterate from the second-to-last row up to the first row.
for ($i = $#nums - 1; $i >= 0; $i--) {
	# Retrieve the values for the current row.
	@this_row = split(' ', $nums[$i]);

	# Iterate through the values in the current row, summing with the max
	# from the row below.
	for $j (0 .. $i) {
		# Set the new values in this row.
		$this_row[$j] += ($bottom[$j] > $bottom[$j + 1]) ?
			$bottom[$j] : $bottom[$j + 1];
	}

	# The new bottom row is the updated values of the current row.
	@bottom = @this_row;
}

# Print the message.
print "Found: $bottom[0]";

