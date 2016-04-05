
#
# Problem 54:
#
# In the card game poker, a hand consists of five cards and are ranked, from
# lowest to highest, in the following way:
# 
# 	* High Card: Highest value card.
# 	* One Pair: Two cards of the same value.
# 	* Two Pairs: Two different pairs.
# 	* Three of a Kind: Three cards of the same value.
# 	* Straight: All cards are consecutive values.
# 	* Flush: All cards of the same suit.
# 	* Full House: Three of a kind and a pair.
# 	* Four of a Kind: Four cards of the same value.
# 	* Straight Flush: All cards are consecutive values of same suit.
# 	* Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
# 
# The cards are valued in the order:
#     2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.
# 
# If two players have the same ranked hands then the rank made up of the
# highest value wins; for example, a pair of eights beats a pair of fives (see
# example 1 below). But if two ranks tie, for example, both players have a pair
# of queens, then highest cards in each hand are compared (see example 4
# below); if the highest cards tie then the next highest cards are compared,
# and so on.
# 
# Consider the following four hands dealt to two players:
# Hand   Player 1           Player 2             Winner
# 1      5H 5C 6S 7S KD     2C 3S 8S 8D TD
#        Pair of Fives      Pair of Eights       Player 2
# 2      5D 8C 9S JS AC     2C 5C 7D 8S QH
#        Highest card Ace   Highest card Queen   Player 1
# 3      2D 9C AS AH AC     3D 6D 7D TD QD
#        Three Aces         Flush with Diamonds  Player 2
# 4      4D 6S 9H QH QC     3D 6D 7H QD QS
#        Pair of Queens     Pair of Queens
#        Highest card Nine  Highest card Seven   Player 1
# 5      2H 2D 4C 4D 4S     3C 3D 3S 9S 9D
#        Full House         Full House
#        With Three Fours   with Three Threes    Player 1
# 
# The file, poker.txt, contains one-thousand random hands dealt to two players.
# Each line of the file contains ten cards (separated by a single space): the
# first five are player one's cards and the last five are player two's cards.
# You can assume that all hands are valid (no invalid characters or repeated
# cards), each player's hand is in no specific order, and in each hand there is
# a clear winner.
# 
# How many hands does player one win?
#

# This is the data file containing all the hands.
$data_file = "p054.txt";

# Open the data file.
open(FILE, $data_file) || die("Could not open file.");

# Read the contents from the file.
@file_contents = <FILE>;

# Close the file.
close(FILE);

# This is used to keep track of the hands won by player 1.
$p1wins = 0;

# Iterate over each line in the file.
for my $line (@file_contents) {
	# Trim the new line characters from the line.
	$line =~ s/\s+$//;

	# Get the sorted individual player hands.
	my $p1hand = sort_hand(substr($line, 0, 14));
	my $p2hand = sort_hand(substr($line, 15, 14));

	# Calculate the point values for the hands.
	my $p1val = get_poker_hand_value($p1hand);
	my $p2val = get_poker_hand_value($p2hand);

	# Increment player 1 win count if necessary.
	$p1wins++ if ($p1val > $p2val);
}

# Print the result.
print "Found: $p1wins\n";

# This is used to retrieve the value for a poker hand.
sub get_poker_hand_value {
	# Get the hand parameter.
	my $hand = shift;

	# Calculate the points for this hand.
	my $pts = get_straight_and_flush_pts($hand) +
			  get_four_of_a_kind_pts($hand) +
			  get_full_house_pts($hand) +
			  get_three_of_a_kind_pts($hand) +
			  get_two_pair_pts($hand) +
			  get_one_pair_pts($hand);

	# If this hand has nothing, set the high card points.
	$pts = get_high_card_pts($hand) if ($pts == 0);

	# Return the identified points for this hand.
	return $pts;
}

# Get the straight flush (and royal straight flush) points for a hand.
sub get_straight_and_flush_pts {
	# Get the hand parameter.
	my $hand = shift;

	# Get the flush and straight points for this hand.
	my $fpts = get_flush_pts($hand);
	my $spts = get_straight_pts($hand);

	# Make sure it is a flush and a straight.
	return 0 if ($fpts == 0 && $spts == 0);

	# Return the points.
	return $fpts + $spts;
}

# Retrieve the points for a four-of-a-kind.
sub get_four_of_a_kind_pts {
	# Get the hand parameter.
	my $hand = shift;

	# This will hold the card values.
	my @v = ( );

	# Put all the card rank values into the list.
	push(@v, get_card_rank($_)) for (split(/ /, $hand));

	# Get the card rank combinations.
	my $comb = get_card_rank_combinations($hand);

	# Return 0 when this is not a four of a kind.
	return 0 if ($comb != 41 && $comb != 14);

	# This will hold the points.
	my $points = 70000000000;

	# Add the points for the card values.
	$points += $v[0] * 100 + $v[4] if ($comb == 41);
	$points += $v[4] * 100 + $v[0] if ($comb == 14);

	# Return the identified point values.
	return $points;
}

# Retrieve the points for a full house.
sub get_full_house_pts {
	# Get the hand parameter.
	my $hand = shift;

	# This will hold the card values.
	my @v = ( );

	# Put all the card rank values into the list.
	push(@v, get_card_rank($_)) for (split(/ /, $hand));

	# Get the card rank combinations.
	my $comb = get_card_rank_combinations($hand);

	# Return 0 when this is not a four of a kind.
	return 0 if ($comb != 32 && $comb != 23);

	# This will hold the points.
	my $points = 60000000000;

	# Add the points for the card values.
	$points += $v[0] * 100 + $v[4] if ($comb == 32);
	$points += $v[4] * 100 + $v[0] if ($comb == 23);

	# Return the identified point values.
	return $points;
}

# Get the flush points for a hand.
sub get_flush_pts {
	# Get the hand parameter.
	my $hand = shift;

	# Return whether the cards are all in the same suit.
	return 0 if (($hand !~ /.C .C .C .C .C/) && ($hand !~ /.D .D .D .D .D/) &&
			($hand !~ /.H .H .H .H .H/) && ($hand !~ /.S .S .S .S .S/));

	# This will hold the points.
	my $points = 50000000000;

	# Get the cards.
	@cards = split(/ /, $hand);

	# Add the card rank values to the point count.
	for ($ci = 0; $ci <= $#cards; $ci++) {
		$points += get_card_rank($cards[$ci]) * (100 ** $ci);
	}

	# Return the points.
	return $points;
}

# Get the straight points for a hand.
sub get_straight_pts {
	# Get the hand parameter.
	my $hand = shift;

	# This will hold the card values.
	my @v = ( );

	# Put all the card values into the list.
	push(@v, get_card_rank($_)) for (split(/ /, $hand));

	# This will keep track of whether the cards are a straight.
	my $straight = true;

	# Check for consecutive values in the first four cards.
	# (Note that Aces have to be on the top end.)
	for ($i = 1; $i < 5 && $straight eq true; $i++) {
		$straight = ($v[$i-1] == $v[$i]-1) ? true : false;
	}

	# Return 0 if not a straight.
	return 0 if($straight ne true);

	# This will hold the points.
	my $points = 40000000000;

	# Get the cards.
	@cards = split(/ /, $hand);

	# Add the card rank values to the point count.
	for ($ci = 0; $ci <= $#cards; $ci++) {
		$points += get_card_rank($cards[$ci]) * (100 ** $ci);
	}

	# Return the points.
	return $points;
}

# Retrieve the points for a three-of-a-kind.
sub get_three_of_a_kind_pts {
	# Get the hand parameter.
	my $hand = shift;

	# This will hold the card values.
	my @v = ( );

	# Put all the card rank values into the list.
	push(@v, get_card_rank($_)) for (split(/ /, $hand));

	# Get the card rank combinations.
	my $comb = get_card_rank_combinations($hand);

	# Return 0 when this is not a three of a kind.
	return 0 if ($comb != 311 && $comb != 131 && $comb != 113);

	# This will hold the points.
	my $points = 30000000000;

	# Add the points for the card values.
	$points += $v[1] * 10000 + $v[4] * 100 + $v[3] if ($comb == 311);
	$points += $v[2] * 10000 + $v[4] * 100 + $v[0] if ($comb == 131);
	$points += $v[4] * 10000 + $v[1] * 100 + $v[0] if ($comb == 113);

	# Return the identified point values.
	return $points;
}

# Retrieve the points for two pairs.
sub get_two_pair_pts {
	# Get the hand parameter.
	my $hand = shift;

	# This will hold the card values.
	my @v = ( );

	# Put all the card rank values into the list.
	push(@v, get_card_rank($_)) for (split(/ /, $hand));

	# Get the card rank combinations.
	my $comb = get_card_rank_combinations($hand);

	# Return 0 when this is not a two-pair hand.
	return 0 if ($comb != 122 && $comb != 212 && $comb != 221);

	# This will hold the points.
	my $points = 20000000000;

	# Add the points for the card values.
	$points += $v[4] * 10000 + $v[2] * 100 + $v[0] if ($comb == 122);
	$points += $v[4] * 10000 + $v[0] * 100 + $v[2] if ($comb == 212);
	$points += $v[2] * 10000 + $v[0] * 100 + $v[4] if ($comb == 221);

	# Return the identified point values.
	return $points;
}

# Retrieve the points for one pair.
sub get_one_pair_pts {
	# Get the hand parameter.
	my $hand = shift;

	# This will hold the card values.
	my @v = ( );

	# Put all the card rank values into the list.
	push(@v, get_card_rank($_)) for (split(/ /, $hand));

	# Get the card rank combinations.
	my $comb = get_card_rank_combinations($hand);

	# Return 0 when this is not a one-pair hand.
	return 0 if ($comb != 2111 && $comb != 1211 && $comb != 1121 && $comb != 1112);

	# This will hold the points.
	my $points = 10000000000;

	# Add the points for the card values.
	$points += $v[0] * 1000000 + $v[4] * 10000 + $v[3] * 100 + $v[2] if ($comb == 2111);
	$points += $v[1] * 1000000 + $v[4] * 10000 + $v[3] * 100 + $v[0] if ($comb == 1211);
	$points += $v[2] * 1000000 + $v[4] * 10000 + $v[1] * 100 + $v[0] if ($comb == 1121);
	$points += $v[3] * 1000000 + $v[2] * 10000 + $v[1] * 100 + $v[0] if ($comb == 1112);

	# Return the identified point values.
	return $points;
}

# Retrieve the high-card points for a hand.
sub get_high_card_pts {
	# Get the hand parameter.
	my $hand = shift;

	# This will hold the points.
	my $points = 0;

	# Get the cards.
	@cards = split(/ /, $hand);

	# Add the card rank values to the point count.
	for ($ci = 0; $ci <= $#cards; $ci++) {
		$points += get_card_rank($cards[$ci]) * (100 ** $ci);
	}

	# Return the identified point values.
	return $points;
}

# Determine the rank of a card.
sub get_card_rank {
	# Get the card parameter.
	my $card = shift;

	# Return the integer value if it is an integer.
	return substr($card, 0, 1) if ($card =~ m/\d[CDHS]/);

	# Return the integer value if it is a 10 or a face card.
	return 10 if ($card =~ m/T[CDHS]/);
	return 11 if ($card =~ m/J[CDHS]/);
	return 12 if ($card =~ m/Q[CDHS]/);
	return 13 if ($card =~ m/K[CDHS]/);
	return 14 if ($card =~ m/A[CDHS]/);
}

# Determine the suit of a card.
sub get_card_suit {
	# Get the card parameter.
	my $card = shift;

	# Return the integer value of the suit.
	return 0 if ($card =~ m/.C/);
	return 1 if ($card =~ m/.D/);
	return 2 if ($card =~ m/.H/);
	return 3 if ($card =~ m/.S/);
}

# Determine the value of a card.
sub get_card_value {
	# Get the card parameter.
	my $card = shift;

	# Return the integer value of the card.
	return get_card_suit($card) + 4 * get_card_rank($card);
}

# Determine the card based on a value.
sub get_card_for_value {
	# Get the value parameter.
	my $value = shift;

	# Get the value of the suit.
	my $suit = int($value % 4);

	# Get the value of the rank.
	my $rank = int($value / 4);

	# This will represent the card.
	my $card;

	# Get the rank for the card.
	$card = $rank if ($rank < 10);
	$card = 'T' if ($rank == 10);
	$card = 'J' if ($rank == 11);
	$card = 'Q' if ($rank == 12);
	$card = 'K' if ($rank == 13);
	$card = 'A' if ($rank == 14);

	# Get the suit for the card.
	$card = $card . 'C' if ($suit == 0);
	$card = $card . 'D' if ($suit == 1);
	$card = $card . 'H' if ($suit == 2);
	$card = $card . 'S' if ($suit == 3);

	# Return the card.
	return $card;
}

# Determine the combination of card ranks.
sub get_card_rank_combinations {
	# Get the hand parameter.
	my $hand = shift;

	# This will hold the combinations.
	my @combs = ( );

	# This will hold the card values.
	my @vals = ( );

	# Put all the card values into the list.
	push(@vals, get_card_rank($_)) for (split(/ /, $hand));

	# Set the initial count to 0.
	my $count = 0;

	# Set the initial prev value to the first element in the array.
	my $prev = $vals[0];

	# Iterate over the card rank values.
	for $val (@vals) {
		# Update the values if necessary.
		$prev = $val and push(@combs, $count) and $count = 0
			if ($val != $prev);

		# Increment the counter.
		++$count;
	}

	# Add the final counter value.
	push(@combs, $count);

	# Return the joined array as the result.
	return join('', @combs);
}

# Order the card values from low to high.
sub sort_hand {
	# Get the hand parameter.
	my $hand = shift;

	# This will hold the card values.
	my @v = ( );

	# Put all the card values into the list.
	push(@v, get_card_value($_)) for (split(/ /, $hand));

	# Sort the list of card values.
	my @s = sort { $a <=> $b } (@v);

	# This will be the new hand.
	my @new_hand = ( );

	# Build the new hand.
	push(@new_hand, get_card_for_value($_)) for (@s);

	# Return the new hand.
	return join(' ', @new_hand);
}

