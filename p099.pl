
#
# Problem 99:
#
# Comparing two numbers written in index form like 2**11 and 3**7 is not
# difficult, as any calculator would confirm that 2**11 = 2048 < 3**7 = 2187.
# 
# However, confirming that 632382**518061 > 519432**525806 would be much more
# difficult, as both numbers contain over three million digits.
# 
# Using base_exp.txt (right click and 'Save Link/Target As...'), a 22K text
# file containing one thousand lines with a base/exponent pair on each line,
# determine which line number has the greatest numerical value.
# 
# NOTE: The first two lines in the file represent the numbers in the example
# given above.
#

# Include the BigInt library.
use Math::BigInt;

# This is the data file containing the numbers.
$data_file = "p099.txt";

# Open the data file.
open(FILE, $data_file) || die("Could not open file.");

# This keeps track of the maximum value.
$max = 0;

# This keeps track of the line with the maximum value.
$max_line = 0;

# This is the current line number.
$linenr = 0;

# Read the lines from the file.
while (++$linenr and $line = <FILE> and chop($line)) {
	# Get the base and the exponent.
	my ($base, $exp) = split(/,/, $line);

	# Get the big value.
	$val = $exp * (log($base));

	# Update the max if necessary.
	$max = $val and $max_line = $linenr if ($val > $max);
}

# Print the result.
print "Found: $max_line\n";

# Close the file.
close(FILE);

