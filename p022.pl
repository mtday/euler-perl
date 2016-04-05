
#
# Problem 22:
#
# Using names.txt (right click and 'Save Link/Target As...'), a 46K text file
# containing over five-thousand first names, begin by sorting it into
# alphabetical order. Then working out the alphabetical value for each name,
# multiply this value by its alphabetical position in the list to obtain a name
# score.
# 
# For example, when the list is sorted into alphabetical order, COLIN, which is
# worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN
# would obtain a score of 938 × 53 = 49714.
# 
# What is the total of all the name scores in the file?
#

use Math::BigInt;

# This is the data file containing the names.
$data_file = "p022.txt";

# Open the data file.
open(FILE, $data_file) || die("Could not open file.");

# Read a line from the file.
$file_contents = <FILE>;

# Close the file.
close(FILE);

# Create a sorted list of names from the file contents.
@names = sort(split(/,/, $file_contents));

# This will hold the total scores.
$total = Math::BigInt->new(0);

# Iterate over all the names.
for $i (1 .. $#names + 1) {
	# Get the name.
	my $name = $names[$i-1];

	# Get rid of the quotes.
	$name =~ s/"//g;

	# Calculate the score for this name.
	my $score = 0;
	$score += ord($_) - 64 for (split(//, $name));

	# Add to the total score.
	$total += $i * $score;
}

# Print the total.
print "Total: $total\n";

