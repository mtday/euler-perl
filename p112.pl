
#
# Problem 112:
#
# Working from left-to-right if no digit is exceeded by the digit to its left
# it is called an increasing number; for example, 134468.
# 
# Similarly if no digit is exceeded by the digit to its right it is called a
# decreasing number; for example, 66420.
# 
# We shall call a positive integer that is neither increasing nor decreasing a
# "bouncy" number; for example, 155349.
# 
# Clearly there cannot be any bouncy numbers below one-hundred, but just over
# half of the numbers below one-thousand (525) are bouncy. In fact, the least
# number for which the proportion of bouncy numbers first exceeds 50% is 538.
# 
# Surprisingly bouncy number become more and more common and by the time we
# reach 21780 the proportion of bouncy numbers is equal to 90%.
# 
# Find the least number for which the proportion of bouncy numbers is exactly
# 99%.
#

# This keeps track of the number of bouncy numbers we have seen.
$bouncy = 0;

# This is the target percentage we are shooting for.
$target_perc = 0.50;

# This is the starting value of n.
$n = 99;

# Iterate until we find the answer.
while ($n++) {
	# Increment the bouncy count if we find a bouncy number.
	$bouncy++ if (is_bouncy($n));

	# Print the solution if we find it.
	print "Found: " . ($n - 1) . "\n" and last
		if ($bouncy / $n > $target_perc);
}


# This is used to determine if a number is bouncy.
sub is_bouncy {
	my $n = shift;
	return 0 if $n < 99;
	return !is_increasing($n) && !is_decreasing($n);
}

# This is used to determine if a number is increasing.
sub is_increasing {
	my $n = shift;
	my @np = split(//, $n);
	for (1 .. $#np) {
		return 0 if ($np[$_] > $np[$_-1]);
	}
	return 1;
}

# This is used to determine if a number is decreasing.
sub is_decreasing {
	my $n = shift;
	my @np = split(//, $n);
	for (1 .. $#np) {
		return 0 if ($np[$_] < $np[$_-1]);
	}
	return 1;
}


