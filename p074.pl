
#
# Problem 74:
#
# The number 145 is well known for the property that the sum of the factorial
# of its digits is equal to 145:
# 
# 1! + 4! + 5! = 1 + 24 + 120 = 145
# 
# Perhaps less well known is 169, in that it produces the longest chain of
# numbers that link back to 169; it turns out that there are only three such
# loops that exist:
# 
# 169 -> 363601 -> 1454 -> 169
# 871 -> 45361 -> 871
# 872 -> 45362 -> 872
# 
# It is not difficult to prove that EVERY starting number will eventually get
# stuck in a loop. For example,
# 
# 69 -> 363600 -> 1454 -> 169 -> 363601 (-> 1454)
# 78 -> 45360 -> 871 -> 45361 (-> 871)
# 540 -> 145 (-> 145)
# 
# Starting with 69 produces a chain of five non-repeating terms, but the
# longest non-repeating chain with a starting number below one million is sixty
# terms.
# 
# How many chains, with a starting number below one million, contain exactly
# sixty non-repeating terms?
#

# This is the maximum value.
$max = 1000000 / 4;

# This will keep track of the 60-term chains.
$count = 0;

# This array will hold our factorial values so we don't have to calculate
# them every time.
@f = ( 1, 1 );
push(@f, $f[$#f] * ($#f+1)) while ($#f < 9);

# This is the starting value for n.
$n = 1;

# Iterate until we find it.
while (++$n < $max) {
	print "$n\n" if ($n % 1000 == 0);
	# This hash will keep track of values we have found.
	%hash = ( );

	# This is the starting value in our chain.
	$i = $n;

	# This will keep track of the chain length.
	$len = 0;

	# Iterate until we hit a value we have already seen.
	while (! exists($hash{$i})) {
		# Add the value to the hash.
		$hash{$i} = 1;

		# Update the chain length.
		$len++;

		# This will hold the sum.
		my $sum = 0;

		# Iterate over each digit in the number.
		for $k ((split(//, $i))) {
			# Add the factorial to the sum.
			$sum += $f[$k];
		}

		# Set the new value.
		$i = $sum;
	}

	# Increment the counter if necessary.
	++$count and
	print "Found one: $n ($count)\n"
	if ($len == 60);
}

# Print the result.
print "Found: $count\n";

