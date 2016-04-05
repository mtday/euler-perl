
#
# Problem 96:
#
# Su Doku (Japanese meaning number place) is the name given to a popular puzzle
# concept. Its origin is unclear, but credit must be attributed to Leonhard
# Euler who invented a similar, and much more difficult, puzzle idea called
# Latin Squares. The objective of Su Doku puzzles, however, is to replace the
# blanks (or zeros) in a 9 by 9 grid in such that each row, column, and 3 by 3
# box contains each of the digits 1 to 9. Below is an example of a typical
# starting puzzle grid and its solution grid.
# 
# A well constructed Su Doku puzzle has a unique solution and can be solved by
# logic, although it may be necessary to employ "guess and test" methods in
# order to eliminate options (there is much contested opinion over this). The
# complexity of the search determines the difficulty of the puzzle; the example
# above is considered easy because it can be solved by straight forward direct
# deduction.
# 
# The 6K text file, sudoku.txt (right click and 'Save Link/Target As...'),
# contains fifty different Su Doku puzzles ranging in difficulty, but all with
# unique solutions (the first puzzle in the file is the example above).
# 
# By solving all fifty puzzles find the sum of the 3-digit numbers found in the
# top left corner of each solution grid; for example, 483 is the 3-digit number
# found in the top left corner of the solution grid above.
#

# This is the data file containing the puzzles.
$data_file = "p096.txt";

# Open the data file.
open(FILE, $data_file) || die("Could not open file.");

# Pull all the lines from the file.
push(@lines, $line) while ($line = <FILE>);

# Close the file.
close(FILE);

# This will hold the sum we are looking for.
$sum = 0;

# Convert the lines into boards.
for ($i = 0; $i < $#lines; $i += 10) {
	# This will hold the numbers for this board.
	my $board = '';

	# Parse 9 lines into a board.
	$board .= substr($lines[$i + $_], 0, 9) for (1 .. 9);

	# Solve the board.
	$board = solve_board($board, 0); 

	# Brute force the rest if we have not found a solution.
	$board = brute_force($board, $depth) if (! is_solved($board));

	# Add the first three numbers to the sum.
	$sum += substr($board, 0, 3) if (is_solved($board));
}

# Print the solution.
print "Found: $sum\n";

# This is used to solve a sudoku board.
sub solve_board {
	# Get the board.
	my $board = shift;

	# Get the depth.
	my $depth = shift;

	# Continue following this pattern until we find no changes.
	while (true) {
		# Fill in all the holes.
		my $after = fill_holes($board);

		# Fill in holes based on intersections.
		$after = fill_intersections($after);

		# Break out if we found no changes in this iteration.
		$board = $after and last if $board eq $after;

		# Set the new board.
		$board = $after;
	}

	# Return the modified board.
	return $board;
}

# This is used to fill in any holes in rows, columns, or grids.
sub fill_holes {
	# Get the board.
	my $board = shift;

	# Iterate over the rows and columns.
	for my $r (0 .. 8) {
		for my $c (0 .. 8) {
			# Get the current value for this position.
			my $val = get_pos($board, $r, $c);

			# Skip any values that are already filled in.
			next if $val != 0;

			# Get potential values for this position.
			my $pot = get_potential($board, $r, $c);

			# Skip when there are more than one potential values.
			next if length($pot) != 1;

			# Fill the position with the new value.
			$board = set_pos($board, $r, $c, $pot);
		}
	}

	# Return the (potentially) modified board.
	return $board;
}

# This is used to fill in any holes based on intersection of rows and columns.
sub fill_intersections {
	# Get the board.
	my $board = shift;

	# Iterate over the grids.
	for my $gr (0 .. 2) {
		# Get the real grid row positions.
		my $agr = $gr;
		my $bgr = ($gr + 1) % 3;
		my $cgr = ($gr + 2) % 3;

		for my $gc (0 .. 2) {
			# Get the real grid column positions.
			my $agc = $gc;
			my $bgc = ($gc + 1) % 3;
			my $cgc = ($gc + 2) % 3;

			# Get the current grid.
			my $grid = get_grid($board, $agr, $agc);

			# Get the other grids in this grid row.
			my $rgridb = get_grid($board, $agr, $bgc);
			my $rgridc = get_grid($board, $agr, $cgc);

			# Get the other grids in this grid column.
			my $cgridb = get_grid($board, $bgr, $agc);
			my $cgridc = get_grid($board, $cgr, $agc);

			# Iterate over the rows and columns in this grid.
			for my $r (0 .. 2) {
				# Get the real row positions.
				my $ar = ($gr * 3 + $r);
				my $br = ($gr * 3 + ($r + 1) % 3);
				my $cr = ($gr * 3 + ($r + 2) % 3);

				# Get the rows.
				my $rowa = get_row($board, $ar);
				my $rowb = get_row($board, $br);
				my $rowc = get_row($board, $cr);

				for my $c (0 .. 2) {
					# Get the real column positions.
					my $ac = $gc * 3 + $c;
					my $bc = $gc * 3 + ($c + 1) % 3;
					my $cc = $gc * 3 + ($c + 2) % 3;

					# Get the columns.
					my $cola = get_col($board, $ac);
					my $colb = get_col($board, $bc);
					my $colc = get_col($board, $cc);

					# Get the value of this position.
					my $v = get_pos($board, $ar, $ac);

					# Move on if this value is already filled in.
					next if $v != 0;

					# Get the potential values for this position.
					my $pos = get_potential($board, $ar, $ac);

					# Iterate over the possible values.
					for my $p (split(//, $pos)) {
						# Check the other columns in this grid column and set
						# the value if we find a match.
						$board = set_pos($board, $ar, $ac, $p)
							if (contains($cgridb, $p) &&
								contains($cgridc, $p) &&
								! is_potential($board, $br, $ac, $p) &&
								! is_potential($board, $cr, $ac, $p));

						# Check the other rows in this grid rows and set
						# the value if we find a match.
						$board = set_pos($board, $ar, $ac, $p)
							if (contains($rgridb, $p) &&
								contains($rgridc, $p) &&
								! is_potential($board, $ar, $bc, $p) &&
								! is_potential($board, $ar, $cc, $p));
					}

				}
			}
		}
	}

	# Return the (potentially) modified board.
	return $board;
}

# This is used to brute force solve a board.
sub brute_force {
	# Get the board.
	my $board = shift;

	# Get the depth.
	my $depth = shift;

	# This is the list of potential boards.
	my @boards = ( $board );

	# Iterate through the available boards.
	while (scalar(@boards) > 0) {
		# Get the current board.
		my $brd = shift @boards;

		# Iterate over the rows and columns.
		for my $r (0 .. 8) {
			for my $c (0 .. 8) {
				# Get the current value for this position.
				my $val = get_pos($brd, $r, $c);

				# Skip any values that are already filled in.
				next if $val != 0;

				# Get potential values for this position.
				my $pot = get_potential($brd, $r, $c);

				# Skip when there are more than two values.
				next if length($pot) != 2;

				# Create two boards based on the two possible values.
				my $board1 = set_pos($brd, $r, $c, substr($pot, 0, 1));
				my $board2 = set_pos($brd, $r, $c, substr($pot, 1, 1));

				# Add these two boards to the list.
				push(@boards, $board1, $board2);

				# Try to solve the first board.
				$board1 = solve_board($board1, $depth + 1);
				return $board1 if (is_solved($board1));

				# Try to solve the second board.
				$board2 = solve_board($board2, $depth + 1);
				return $board2 if (is_solved($board2));
			}
		}
	}

	# Return the board.
	return $board;
}

# This is used to retrieve a grid from a board.
sub get_grid {
	# Get the board.
	my $board = shift;

	# Get the grid row and column to retrieve.
	my $gr = shift;
	my $gc = shift;

	# Build the requested grid.
	my $grid = '';
	$grid .= substr($board, ($gr * 3 + $_) * 9 + ($gc * 3), 3) for (0 .. 2);

	# Return the requested grid.
	return $grid;
}

# This is used to retrieve a row from a board.
sub get_row {
	# Get the board.
	my $board = shift;

	# Get the row to retrieve.
	my $r = shift;

	# Return the requested row.
	return substr($board, $r * 9, 9);
}

# This is used to retrieve a column from a board.
sub get_col {
	# Get the board.
	my $board = shift;

	# Get the column to retrieve.
	my $c = shift;

	# Build the requested column.
	my $col = '';
	$col .= substr($board, $_ * 9 + $c, 1) for (0 .. 8);

	# Return the requested col.
	return $col;
}

# This is used to retrieve the value for a specific position on the board.
sub get_pos {
	# Get the board.
	my $board = shift;

	# Get the row and column to retrieve.
	my $r = shift;
	my $c = shift;

	# Return the value.
	return substr($board, $r * 9 + $c, 1);
}

# This is used to set the value for a specific position on the board.
sub set_pos {
	# Get the board.
	my $board = shift;

	# Get the row and column to retrieve.
	my $r = shift;
	my $c = shift;

	# Get the new value.
	my $v = shift;

	# This is the new board.
	my @new = split(//, $board);

	# Splice in the new value.
	splice(@new, $r * 9 + $c, 1, ($v));

	# Return the modified board.
	return join('', @new);
}

# This is used to determine potential values for a location on the board.
sub get_potential {
	# Get the board.
	my $board = shift;

	# Get the row and column to retrieve.
	my $r = shift;
	my $c = shift;

	# Get the current value.
	my $curr = get_pos($board, $r, $c);

	# If this spot is not blank, return its current value.
	return $curr if $curr != 0;

	# These are the potential values.
	my $pot = "123456789";

	# Get the row, column, and grid for this position.
	my $row = get_row($board, $r);
	my $col = get_col($board, $c);
	my $grid = get_grid($board, int($r/3), int($c/3));

	# Get rid of all the existing numbers.
	$pot =~ s/$_// foreach (split(//, "$row$col$grid"));

	# Return the list of potential values.
	return $pot;
}

# This is used to determine if a value could fit into a position.
sub is_potential {
	# Get the board.
	my $board = shift;

	# Get the row and column to retrieve.
	my $r = shift;
	my $c = shift;

	# Get the potential value.
	my $p = shift;

	# Get the list of potential values.
	my $pot = get_potential($board, $r, $c);

	# Return whether the specified value is part of the potential values.
	return $pot =~ /$p/;
}

# This is used to check whether a row, column, or grid contains a value.
sub contains {
	# Get the piece to search in.
	my $piece = shift;

	# Get the value to look for.
	my $v = shift;

	# Return whether the piece contains the value.
	return $piece =~ /$v/;
}

# This is used to determine the missing numbers in a row, column, or grid.
sub get_missing {
	# Get the sorted existing numbers.
	my @existing = sort(split(//, shift));

	# This is what we are expecting.
	my $exp = "123456789";

	# Remove what we have from what we are expecting.
	$exp =~ s/$_// foreach (@existing);

	# Return what we still need.
	return $exp;
}

# This is used to determine whether a board is solved.
sub is_solved {
	# Get the board.
	my $board = shift;

	# Return whether the board contains any zeros.
	return $board !~ /0/;
}

# This is used to print a board.
sub print_board {
	# Get the board to print.
	my $board = shift;

	# Iterate over the rows.
	for my $r (0 .. 8) {
		# Print the row separator if necessary.
		print "+-------+-------+-------+\n" if ($r % 3 == 0);

		# Print the left border for this row.
		print "| ";

		# Iterate over the columns.
		for my $c (0 .. 8) {
			# Print the column separator if necessary.
			print "| " if ($c == 3 || $c == 6);

			# Print the value of this position.
			print get_pos($board, $r, $c) . " ";
		}

		# Print the right border for this row.
		print "|\n";
	}

	# Print the final row separator.
	print "+-------+-------+-------+\n";
}

