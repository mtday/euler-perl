
#
# Problem 124:
#
# The radical of n, rad(n), is the product of distinct prime factors of n. For
# example, 504 = 2**3 × 3**2 × 7, so rad(504) = 2 × 3 × 7 = 42.
# 
# If we calculate rad(n) for 1 <= n <= 10, then sort them on rad(n), and
# sorting on n if the radical values are equal, we get:
#
#     Unsorted                     Sorted
#    n     rad(n)           n       rad(n)     k
#    1       1              1         1        1
#    2       2              2         2        2
#    3       3              4         2        3
#    4       2              8         2        4
#    5       5              3         3        5
#    6       6              9         3        6
#    7       7              5         5        7
#    8       2              6         6        8
#    9       3              7         7        9
#   10      10             10        10       10
# 
# Let E(k) be the kth element in the sorted n column; for example, E(4) = 8 and
# E(6) = 9.
# 
# If rad(n) is sorted for 1 <= n <= 100000, find E(10000).
#

# This is the max n we will go to.
$max = 100000;

# This is the E value we are looking for.
$e = 10000;

# This has will hold the rad values.
%hash = ( );

# Iterate up through the range.
for $n (1 .. $max) {
	# Get the radical for n.
	my $r = rad($n);

	# Find the radical of n and add it to the hash.
	$hash{$r} = exists($hash{$r}) ? "$hash{$r},$n" : $n;
}

# Get the sorted hash keys as the sorted radicals.
@s_rads = sort { $a <=> $b } keys(%hash);

# Get the sorted n values.
@s_n = ( ); push(@s_n, split(/,/, $hash{$_})) for (@s_rads);

# Print the result.
print "Found: $s_n[$e-1]\n";


# This is used to calculate the radical for a number.
sub rad {
	# Get the parameter.
	my $n = shift;

	# Get the prime factors for this value.
	my @pf = get_prime_factors($n);

	# Determine the unique prime factors for this number.
	my %seen = ();
	my @uniq = grep { ! $seen{$_} ++ } @pf;

	# Multiply the unique prime factors together.
	my $prod = 1; $prod *= $_ for (@uniq);

	# Return the identified product.
	return $prod;
}

# This is used to determine whether a number is a prime.
sub is_prime {
	# Get the parameter.
	my $p = shift;

	# 1 is not prime, and 2 is.
	return false eq true if ($p == 1);
	return true eq true if ($p == 2);

	# Define the square root of the value.
	my $sqrt = int(sqrt $p) + 1;

	# Keep track of whether it is a prime.
	my $prime = true;

	# Iterate from 2 to the square root to test for primality.
	for my $t (2 .. $sqrt) {
		# Check to see if the potential prime is evenly divisible by $t.
		$prime = false and last if ($p % $t == 0);
	}

	# Return whether it is prime or not.
	return $prime eq true;
}


# This is used to retrieve the sorted list of prime factors for the parameter.
sub get_prime_factors {
	# Get the parameter.
	my $p = shift;

	# This will hold the prime factors.
	my @f = ( );

	# No prime factors for the number 1.
	return @f if ($p == 1);

	# If it is already a prime, return it.
	return $p if (is_prime($p));

	# Check if 2 is a prime factor.
	push(@f, 2) and $p = $p / 2 while ($p % 2 == 0);

	# Define the square root of the value.
	my $sqrt = int(sqrt $p) + 1;

	# Iterate from 3 to the square root to test for divisibility.
	for ($t = 3; $t <= $sqrt; $t += 2) {
		# If it is divisible by this prime, the prime is a factor.
		push(@f, $t) and $p = $p / $t and last if ($p % $t == 0);
	}

	# Get the rest of the prime factors.
	push(@f, get_prime_factors($p));

	# Return the identified list of prime factors.
	return @f;
}

