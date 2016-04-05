
#
# Problem 102:
#
# Three distinct points are plotted at random on a Cartesian plane, for which
# -1000 = x, y = 1000, such that a triangle is formed.
# 
# Consider the following two triangles:
# 
#            A(-340,495), B(-153,-910), C(835,-947)
#            
#            X(-175,41), Y(-421,-714), Z(574,-645)
# 
# It can be verified that triangle ABC contains the origin, whereas triangle
# XYZ does not.
# 
# Using triangles.txt (right click and 'Save Link/Target As...'), a 27K text
# file containing the co-ordinates of one thousand "random" triangles, find the
# number of triangles for which the interior contains the origin.
# 
# NOTE: The first two examples in the file represent the triangles in the
# example given above.
#

# This is the data file containing the points.
$data_file = "p102.txt";

# Open the data file.
open(FILE, $data_file) || die("Could not open file.");

# Pull all the lines from the file.
push(@lines, $line) while ($line = <FILE>);

# Close the file.
close(FILE);

# This will keep track of the number of triangles that contain the origin.
$count = 0;

# Iterate through the lines in the file.
for $line (@lines) {
	# Parse the list of points from the line.
	@points = split(/,/, $line);

	# Update the count if necessary.
	$count++ if (contains_origin(@points));
}

# Print the result.
print "Found: $count\n";

# This is used to determine if three points of a triangle contains the origin.
sub contains_origin {
	# Get the parameters.
	my ($x1, $y1, $x2, $y2, $x3, $y3) = @_;

	# Compute the dot products.
	my $t1 = ($y2-$y1) * (0-$x1) + ($x1-$x2) * (0-$y1);
	my $t2 = ($y2-$y1) * ($x3-$x1) + ($x1-$x2) * ($y3-$y1);
	my $t3 = ($y3-$y1) * (0-$x1) + ($x1-$x3) * (0-$y1);
	my $t4 = ($y3-$y1) * ($x2-$x1) + ($x1-$x3) * ($y2-$y1);
	my $t5 = ($y3-$y2) * (0-$x2) + ($x2-$x3) * (0-$y2);
	my $t6 = ($y3-$y2) * ($x1-$x2) + ($x2-$x3) * ($y1-$y2);

	# Return the result.
	return ($t1*$t2 >= 0 && $t3 * $t4 >= 0 && $t5 * $t6 >= 0);
}

