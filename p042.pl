
#
# Problem 42:
#
# The nth term of the sequence of triangle numbers is given by, tn = n(n+1)/2;
# so the first ten triangle numbers are:
# 
#     1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
# 
# By converting each letter in a word to a number corresponding to its
# alphabetical position and adding these values we form a word value. For
# example, the word value for SKY is 19 + 11 + 25 = 55 = t10. If the word value
# is a triangle number then we shall call the word a triangle word.
# 
# Using words.txt (right click and 'Save Link/Target As...'), a 16K text file
# containing nearly two-thousand common English words, how many are triangle
# words?
#

# This will hold all the triangle numbers we have identified.
%tnums = ( );

# This will hold the highest triangle number identified.
$max_tnum = 0;

# This will hold the n value for the max triangle number identified.
$max_tnum_n = 0;

# This will hold the count of triangle words.
$count = 0;

# This is the data file containing the words.
$data_file = "p042.txt";

# Open the data file.
open(FILE, $data_file) || die("Could not open file.");

# Read a line from the file.
$file_contents = <FILE>;

# Close the file.
close(FILE);

# Create a sorted list of words from the file contents.
@words = sort(split(/,/, $file_contents));

# Iterate over all the words.
for $w (@words) {
	# Get the word value.
	$val = get_word_value($w);

	# Check for more triangle numbers if necessary.
	if ($val > $max_tnum) {
		# Continually add triangle numbers to the hash until we get far enough.
		while ($max_tnum < $val) {
			# Increase the n value.
			$max_tnum_n++;

			# Find the new triangle number.
			$max_tnum = $max_tnum_n * ($max_tnum_n + 1) / 2;

			# Add the value to the hash.
			$tnums{$max_tnum} = 1;
		}
	}

	# Increase the counter if necessary.
	$count++ if ($val <= $max_tnum && $tnums{$val} ne undef);
}

# Print the identified count.
print "Found: $count\n";

# This is used to convert a word into its integer value.
sub get_word_value {
	# Get the word.
	my $word = shift;

	# Get rid of the quotes.
	$word =~ s/"//g;

	# Calculate the value for this word.
	my $value = 0;
	$value += ord($_) - 64 for (split(//, $word));

	# Return the value.
	return $value;
}

