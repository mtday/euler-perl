
#
# Problem 17:
#
# If the numbers 1 to 5 are written out in words: one, two, three, four, five,
# then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
# 
# If all the numbers from 1 to 1000 (one thousand) inclusive were written out
# in words, how many letters would be used?
# 
# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
# forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20
# letters. The use of "and" when writing out numbers is in compliance with
# British usage.
#

# The lists of individual numbers.
@ones = qw(one two three four five six seven eight nine);
@teens = qw(ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen);
@tens = qw(twenty thirty forty fifty sixty seventy eighty ninety);

# This will hold the letter count.
$count = length("onethousand");

# Iterate over the ones.
for my $one (@ones) {
	# Add the ones (1 - 9).
	$count += length($one);

	# Add the hundreds (100, 200, 300, ..., 900).
	$count += length($one) + length("hundred");

	# Iterate over the ones again.
	for my $one2 (@ones) {
		# Add hundreds and ones (101 - 109, 201 - 209, ..., 901 - 909).
		$count += length($one) + length("hundredand") + length($one2);
	}

	# Iterate over the teens.
	for my $teen (@teens) {
		# Add hundreds and teens (110 - 119, 210 - 219, ..., 910 - 919).
		$count += length($one) + length("hundredand") + length($teen);
	}

	# Iterate over the tens.
	for my $ten (@tens) {
		# Add hundreds and tens (120, 130, 140, ..., 190, 220, ..., 990).
		$count += length($one) + length("hundredand") + length($ten);

		# Iterate over the ones again.
		for my $one2 (@ones) {
			# Add hundreds, tens, and ones (121 - 129, 131 - 139, ...,
			# 991 - 999).
			$count += length($one) + length("hundredand") +
				length($ten) + length($one2);
		}
	}
}

# Iterate over the teens.
for my $teen (@teens) {
	# Add the teens (10, 11, ..., 19).
	$count += length($teen);
}

# Iterate over the tens.
for my $ten (@tens) {
	# Add the tens (20, 30, 40, ..., 90).
	$count += length($ten);

	# Iterate over the ones.
	for my $one (@ones) {
		# Add the tens and ones (21 - 29, 31 - 39, ..., 91 - 99).
		$count += length($ten) + length($one);
	}
}

# Print the count.
print "Count: $count\n";

