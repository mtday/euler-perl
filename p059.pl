
#
# Problem 59:
#
# Each character on a computer is assigned a unique code and the preferred
# standard is ASCII (American Standard Code for Information Interchange). For
# example, uppercase A = 65, asterisk (*) = 42, and lowercase k = 107.
# 
# A modern encryption method is to take a text file, convert the bytes to
# ASCII, then XOR each byte with a given value, taken from a secret key. The
# advantage with the XOR function is that using the same encryption key on the
# cipher text, restores the plain text; for example, 65 XOR 42 = 107, then 107
# XOR 42 = 65.
# 
# For unbreakable encryption, the key is the same length as the plain text
# message, and the key is made up of random bytes. The user would keep the
# encrypted message and the encryption key in different locations, and without
# both "halves", it is impossible to decrypt the message.
# 
# Unfortunately, this method is impractical for most users, so the modified
# method is to use a password as a key. If the password is shorter than the
# message, which is likely, the key is repeated cyclically throughout the
# message. The balance for this method is using a sufficiently long password
# key for security, but short enough to be memorable.
# 
# Your task has been made easy, as the encryption key consists of three lower
# case characters. Using cipher1.txt (right click and 'Save Link/Target
# As...'), a file containing the encrypted ASCII codes, and the knowledge that
# the plain text must contain common English words, decrypt the message and
# find the sum of the ASCII values in the original text.
#

# This is the data file containing the encrypted data.
$data_file = "p059.txt";

# Open the data file.
open(FILE, $data_file) || die("Could not open file.");

# Read the contents from the file.
$file_contents = <FILE>;

# Close the file.
close(FILE);

# This is the list of encrypted characters.
@chars = split(',', $file_contents);

# This is the needed percentage of readable characters to be considered "English".
$perc = 0.99;

# Iterate over all the possible key combinations.
for $key ('aaa' .. 'zzz') {
	# Decrypt the message using the key.
	my ($message, $ratio) = decrypt($key);

	# Continue on if the message does not pass the threshold.
	next if ($ratio < $perc);

	# This will hold the sum of ASCII values.
	my $sum = 0;

	# Iterate through all the characters in the original text and add the
	# ordinal value to the sum.
	$sum += ord($_) for (split(//, $message));

	# Print the result.
	print "Sum: $sum\n" and last;
}

# This is used to decrypt a string of text using a key.
sub decrypt {
	# Get the decryption key.
	my $key = shift;

	# This will hold the clear-text message.
	my $clear_txt = '';

	# This will keep track of the number of readable characters.
	my $readable = 0;

	# Iterate over all the characters.
	for ($chi = 0; $chi <= $#chars; $chi++) {
		# Get the encoded character.
		$enc = $chars[$chi];

		# Get the key value for this character.
		$k = ord(substr($key, $chi % length($key), 1));

		# Get the real character based on the key.
		$real = chr($enc ^ $k);

		# Add the real character to the clear text.
		$clear_txt .= $real;

		# Keep track of whether this was a readable character or not.
		$readable++ if ($real =~ /[A-Za-z0-9\s\.,']/);
	}

	# Return the list of results.
	return ($clear_txt, $readable / scalar(@chars));
}

