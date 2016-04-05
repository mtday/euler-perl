
#
# Problem 43:
#
# The number, 1406357289, is a 0 to 9 pandigital number because it is made up
# of each of the digits 0 to 9 in some order, but it also has a rather
# interesting sub-string divisibility property.
# 
# Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note
# the following:
# 
# 	* d2d3d4=406 is divisible by 2
# 	* d3d4d5=063 is divisible by 3
# 	* d4d5d6=635 is divisible by 5
# 	* d5d6d7=357 is divisible by 7
# 	* d6d7d8=572 is divisible by 11
# 	* d7d8d9=728 is divisible by 13
# 	* d8d9d10=289 is divisible by 17
# 
# Find the sum of all 0 to 9 pandigital numbers with this property.
#

# This will hold the sum of the numbers.
$sum = 0;

print "Generating Permutations...\n";

# Retrieve all permutations 0-9 pandigital numbers.
@arr = generate_permutations('0123456789');

print "Looking for matches...\n";

# Iterate over the numbers to identify those that match the pattern.
for $n (@arr) {
	# Get the substr parts.
	$a = substr($n, 1, 3);
	$b = substr($n, 2, 3);
	$c = substr($n, 3, 3);
	$d = substr($n, 4, 3);
	$e = substr($n, 5, 3);
	$f = substr($n, 6, 3);
	$g = substr($n, 7, 3);

	# Update the sum if the number matches the pattern.
	$sum += $n and print "Found $n\n"
		if ($a % 2 == 0 && $b % 3 == 0 && $c % 5 == 0 && $d % 7 == 0 &&
				$e % 11 == 0 && $f % 13 == 0 && $g % 17 == 0);
}

# Print the sum.
print "Sum: $sum\n";

# This is used to generate an array of all the possible permutations of
# the string parameter (with unique characters).
sub generate_permutations {
	# Get the parameter.
	my $str = shift;

	# This will hold all the identified permutations.
	my @perms = ( );

	# Calculate the length of the provided parameter.
	my $len = length($str);

	# If the length is 2, simply add the as-is and it's reverse.
	if ($len == 2) {
		push(@perms, $str);
		push(@perms, "" . reverse($str));
	} else {
		# Iterate over all the characters in the string.
		for my $i (0 .. $len - 1) {
			# Pull a single character.
			my $x = substr($str, $i, 1);

			# Get the rest of the string, without the pulled-out char.
			my $xs = $str;
			$xs =~ s/$x//;

			# Retrieve all the permutations for the rest of the string.
			my @subarr = generate_permutations($xs);

			# Add the pulled-out character to the beginning of all the
			# sub-elements.
			foreach my $s (@subarr) {
				push(@perms, $x . $s);
			}
		}
	}

	# Return all the identified permutations.
	return @perms;
}

