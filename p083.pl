
#
# Problem 83:
#
# In the 5 by 5 matrix below, the minimal path sum from the top left to the
# bottom right, by moving left, right, up, and down, is indicated in red and is
# equal to 2297. (131, 201, 96, 342, 234, 103, 18, 150, 111, 422, 121, 37, 331)
# 
#   
#                 131 673  234  103   18
#                 201  96  342  965  150
#                 630 803  746  422  111
#                 537 699  497  121  956
#                 805 732  524   37  331
#   
# 
# Find the minimal path sum, in matrix.txt (right click and 'Save Link/Target
# As...'), a 31K text file containing a 80 by 80 matrix, from the top left to
# the bottom right by moving left, right, up, and down.
# 
# NOTE: This problem is a significantly more challenging version of Problem 81.
#


#
# We build a graph from the matrix and use Dijkstra's algorithm to find the
# shortest path.
#

# This is the data file containing the numbers.
$data_file = "p083.txt";

# Open the data file.
open(FILE, $data_file) || die("Could not open file.");

# Pull all the numbers from the file.
push(@nums, split(/,/, $num)) while ($num = <FILE> and chop($num));

# Close the file.
close(FILE);

# Determine the size of the grid.
$size = sqrt(scalar(@nums));

# This will hold the nodes in the graph.
@nodes = ( );

# This will hold all the edges of the graph.
%edges = ( );

# This will hold all the distances.
%dists = ( );

# This will hold the linkages of the shortest paths.
%paths = ( );

# Iterate over the rows and columns of the matrix to build the graph.
for $r (0 .. $size-1) {
	for $c (0 .. $size-1) {
		# This is the node id for this location.
		my $node = "$r:$c";

		# Get the corresponding value for this node.
		my $v = $nums[$r * $size + $c];

		# Set the initial distance to infinity (undefined).
		$dists{$node} = undef;

		# Set the initial path value for this node.
		$paths{$node} = undef;

		# Iterate over the rows and columns of the matrix.
		push(@nodes, $node);

		# Add the linkage to the northern cell if necessary.
		$edges{$node}{($r-1) . ":$c"} = $v if ($r > 0);

		# Add the linkage to the southern cell if necessary.
		$edges{$node}{($r+1) . ":$c"} = $v if ($r < $size-1);

		# Add the linkage to the western cell if necessary.
		$edges{$node}{"$r:" . ($c-1)} = $v if ($c > 0);

		# Add the linkage to the eastern cell if necessary.
		$edges{$node}{"$r:" . ($c+1)} = $v if ($c < $size-1);
	}
}


# This is the root node in the graph.
$root = "0:0";

# This is the ending node.
$end = ($size-1) . ":" . ($size-1);

# Set the distance to the root node.
$dists{$root} = 0;


# This is used to perform sorting using the distance graph.
sub sort_by_distance {
	# Make sure the first distance is defined.
	($dists{$a} eq undef) ? 1 :

	# Make sure the second distance is defined.
	($dists{$b} eq undef) ? -1 :

	# Return the comparison of the distances.
	$dists{$a} <=> $dists{$b};
}


# This is the list of unsolved nodes.
@unsolved = @nodes;

# This is the list of solved nodes.
@solved = ( );

# Iterate while we have unsolved nodes.
while (@unsolved) {
	# Sort the unsolved nodes by distance from the root node.
	@unsolved = sort sort_by_distance @unsolved;

	# Sort the unsolved nodes by distance from the root node.
	push (@solved, $node = shift @unsolved);

	# Now look at all the nodes connected to this node.
	for $n2 (keys %{$edges{$node}}) {
		# Check to see if any distances can be improved.
		if ($dists{$n2} eq undef ||
		   ($dists{$n2} > ($dists{$node} + $edges{$node}{$n2}))) {

			# Set the new distance value.
		    $dists{$n2} = $dists{$node} + $edges{$node}{$n2};

			# Save the path.
			$paths{$n2} = $node;
		}
	}
}

# This will hold the sum of the shortest path.
$sum = 0;

# Iterate from the end cell to the root cell.
while ($end ne $root) {
	# Split this node into its row and column values.
	my ($r, $c) = split(/:/, $end);

	# Get the value for this node.
	$sum += $v = $nums[$r * $size + $c];

	# Move on to the next node.
	$end = $paths{$end};
}

# Add the final value.
$sum += $nums[0];

print "Found: $sum\n";

