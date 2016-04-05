
#
# Problem 79:
#
# A common security method used for online banking is to ask the user for three
# random characters from a passcode. For example, if the passcode was 531278,
# they may asked for the 2nd, 3rd, and 5th characters; the expected reply would
# be: 317.
# 
# The text file, keylog.txt, contains fifty successful login attempts.
# 
# Given that the three characters are always asked for in order, analyse the
# file so as to determine the shortest possible secret passcode of unknown
# length.
#


# This is the data file containing the numbers.
$data_file = "p079.txt";

# Open the data file.
open(FILE, $data_file) || die("Could not open file.");

# Iterate while there are numbers still in the list.
push(@nums, $num) while ($num = <FILE> and chop($num));

# Close the file.
close(FILE);

# This is the starting value.
$n = 100000;

# Continue iterating until we're done.
while (++$n) {
	# Keep track of whether we are okay.
	$ok = 1;

	# Iterate through all the numbers.
	for $num (@nums) {
		# Build a regular expression to match against.
		$regex = ".*" . join('.*', split(//, $num)) . ".*";

		# Set ok to false if it does not match.
		$ok = -1 and last if ($n !~ /$regex/);
	}

	# Print a message and break out if we find it.
	print "Found: $n\n" and last if ($ok > 0);
}

