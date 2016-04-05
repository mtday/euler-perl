
#
# Problem 19:
#
# You are given the following information, but you may prefer to do some
# research for yourself.
# 
# 	* 1 Jan 1900 was a Monday.
# 	* Thirty days has September,
# 	  April, June and November.
# 	  All the rest have thirty-one,
# 	  Saving February alone,
# 	  Which has twenty-eight, rain or shine.
# 	  And on leap years, twenty-nine.
# 	* A leap year occurs on any year evenly divisible by 4, but not on a
# 	  century unless it is divisible by 400.
# 
# How many Sundays fell on the first of the month during the twentieth century
# (1 Jan 1901 to 31 Dec 2000)?
#

# The normal number of days per month (obviously feb will change on leap years).
@days_per_month = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

# The current day.
@day = (1900, '01', '01', 1); # 1900/01/01, Mon

# This will keep count of the Sundays found.
$sundays = 0;

# This is the day being processed.
$daystr = join('-', @day);

# Keep iterating until we hit the end of the 20th century.
while ($daystr !~ m/^2000-12-31.*/) {
	# Check to see if we should increment the Sunday count.
	$sundays++ if ($daystr gt "1901-01-01" && $day[2] eq '01' && $day[3] == 0);

	# Move to the next day.

	# Get the number of days in this month.
	$dpm = $days_per_month[$day[1]-1];
	$dpm = 29 if ($day[1] == 2 && $day[0] % 4 == 0 && $day[0] != 1900);

	# Increase the day of the week.
	$day[3] = ($day[3] + 1) % 7;

	# Find the next day of the month.
	$tmp_day = sprintf "%02d", ($day[2] + 1 > $dpm ? 1 : $day[2] + 1);

	# Increase the month if necessary.
	if ($tmp_day lt $day[2]) {
		# Find the next month.
		$tmp_mth = sprintf "%02d", ($day[1] + 1 == 13 ? 1 : $day[1] + 1);

		# Increase the year if necessary.
		$day[0]++ if ($tmp_mth lt $day[1]);

		# Increase the month.
		$day[1] = $tmp_mth;
	}

	# Increase the day of the month.
	$day[2] = $tmp_day;

	# This is the next day to process.
	$daystr = join('-', @day);
}

# Print the result
print "Sundays: $sundays\n";

