
#
# Problem 24:
#
# A permutation is an ordered arrangement of objects. For example, 3124 is one
# possible permutation of the digits 1, 2, 3 and 4. If all of the permutations
# are listed numerically or alphabetically, we call it lexicographic order. The
# lexicographic permutations of 0, 1 and 2 are:
# 
#                 012   021   102   120   201   210
# 
# What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4,
# 5, 6, 7, 8 and 9?
#

# (Total permutations: 10! == 3628800)

# This is the ordered permutation value we are looking for.
$perm = 1000000;

# Generate all the permutations for the requested characters.
@arr = generate_permutations('0123456789');

# Print the identified target value.
print "Target Value: $arr[$perm-1]\n";

# This is used to generate an array of all the possible permutations of
# the string parameter (with unique characters).
sub generate_permutations {
	# Get the parameter.
	my $str = shift;

	# This will hold all the identified permutations.
	my @perms = ( );

	# Calculate the length of the provided parameter.
	$len = length($str);

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

