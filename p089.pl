
#
# Problem 89:
#
# The rules for writing Roman numerals allow for many ways of writing each
# number (see FAQ: Roman Numerals). However, there is always a "best" way of
# writing a particular number.
# 
# For example, the following represent all of the legitimate ways of writing
# the number sixteen:
# 
#           IIIIIIIIIIIIIIII
#           VIIIIIIIIIII
#           VVIIIIII
#           XIIIIII
#           VVVI
#           XVI
# 
# The last example being considered the most efficient, as it uses the least
# number of numerals.
# 
# The 11K text file, roman.txt (right click and 'Save Link/Target As...'),
# contains one thousand numbers written in valid, but not necessarily minimal,
# Roman numerals; that is, they are arranged in descending units and obey the
# subtractive pair rule (see FAQ for the definitive rules for this problem).
# 
# Find the number of characters saved by writing each of these in their minimal
# form.
# 
# Note: You can assume that all the Roman numerals in the file contain no more
# than four consecutive identical units.
#


# This is the data file containing the numbers.
$data_file = "p089.txt";

# Open the data file.
open(FILE, $data_file) || die("Could not open file.");

# Pull all the numbers from the file.
push(@lines, $roman) while ($roman = <FILE>);

# Close the file.
close(FILE);

# This has holds the standard roman numeral values.
%rvals = ( 'I' => 1, 'V' => 5, 'X' => 10, 'L' => 50, 'C' => 100,
		   'D' => 500, 'M' => 1000 );

# This will keep track of the number of letters saved.
$saved = 0;

# Iterate through all the lines in the file.
for $orig_rom (@lines) {
	# Get rid of any white space.
	$orig_rom =~ s/\s+//g;

	# Get the length of the original value.
	$orig_len = length($orig_rom);

	# Convert the original value into a number.
	$orig_val = from_roman($orig_rom);

	# Convert the number into a new roman numeral.
	$new_rom = to_roman($orig_val);

	# Get the length of the new value.
	$new_len = length($new_rom);

	# Convert the new roman numeral back into a number.
	$new_val = from_roman($new_rom);

	# Update the number of saved letters.
	$saved += $orig_len - $new_len;
}

# Print the result.
print "Found: $saved\n";

# Retrieve the integer value for a roman numeral.
sub from_roman {
	# Get the roman numeral.
	my $r = shift;

	# This will hold the sum.
	my $sum = 0;

	# This is the previous value seen.
	my $prev = undef;

	# Iterate over all the letters.
	for $l ((split(//, $r))) {
		# Get the value for this letter.
		my $v = $rvals{$l};

		# Add the value to the sum for this number.
		$sum += $v;

		# Update the sum in the case of subtractive combinations.
		$sum -= 2 * $prev if ($prev ne undef && $prev < $v);

		# Update the previous value.
		$prev = $v;
	}

	# Return the identified value.
	return $sum;
}

# Retrieve the roman numeral value for an integer.
sub to_roman {
	# Get the integer.
	my $i = shift;

	# This will hold the letters.
	my $s = '';

	# Check to see if we need to add Ms.
	if ($i >= 1000) {
		# Add all the M values necessary.
		$s .= 'M' for (1 .. $i / 1000);

		# Update the number.
		$i %= 1000;
	}

	# Check to see if we need to add a CM.
	if ($i >= 900) {
		# Add the CM.
		$s .= 'CM';

		# Update the number.
		$i -= 900;
	}

	# Check to see if we need to add a D.
	if ($i >= 500) {
		# Add the D.
		$s .= 'D';

		# Update the number.
		$i -= 500;
	}

	# Check to see if we need to add a CD.
	if ($i >= 400) {
		# Add the CD.
		$s .= 'CD';

		# Update the number.
		$i -= 400;
	}

	# Check to see if we need to add some Cs.
	if ($i >= 100) {
		# Add all the C values necessary.
		$s .= 'C' for (1 .. $i / 100);

		# Update the number.
		$i %= 100;
	}

	# Check to see if we need to add an XC.
	if ($i >= 90) {
		# Add the XC.
		$s .= 'XC';

		# Update the number.
		$i -= 90;
	}

	# Check to see if we need to add an L.
	if ($i >= 50) {
		# Add the L.
		$s .= 'L';

		# Update the number.
		$i -= 50;
	}

	# Check to see if we need to add an XL.
	if ($i >= 40) {
		# Add the XL.
		$s .= 'XL';

		# Update the number.
		$i -= 40;
	}

	# Check to see if we need to add some Xs.
	if ($i >= 10) {
		# Add all the X values necessary.
		$s .= 'X' for (1 .. $i / 10);

		# Update the number.
		$i %= 10;
	}

	# Check to see if we need to add an IX.
	if ($i >= 9) {
		# Add the IX.
		$s .= 'IX';

		# Update the number.
		$i -= 9;
	}

	# Check to see if we need to add a V.
	if ($i >= 5) {
		# Add the V.
		$s .= 'V';

		# Update the number.
		$i -= 5;
	}

	# Check to see if we need to add an IV.
	if ($i >= 4) {
		# Add the IV.
		$s .= 'IV';

		# Update the number.
		$i -= 4;
	}

	# Add all the I values necessary.
	$s .= 'I' for (1 .. $i);

	# Return the roman numeral value.
	return $s;
}

