List<String> generateHorizontalMonthGrid(int monthStartsOn, int daysInMonth) {
  const List<String> weekdays = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat'
  ];

  List<String> grid = List<String>.filled(42, '');

  int date = 1;
  monthStartsOn = monthStartsOn % 7;

  for (int i = 0; i < grid.length;) {
    if (i <= 6) {
      grid[i] = weekdays[i % 7];
    }
    // Empty cells before the month starts
    else if (i > 6 && monthStartsOn-- > 0) {
      grid[i] = '';
    }
    // Actual days of the month
    else if (i > 6 && date <= daysInMonth) {
      grid[i] = (date++).toString();
    }

    i++;

    // Restart from 7 if dates are left and grid is filled
    if (date <= daysInMonth && i == grid.length) {
      i = weekdays.length;
    }
  }
  print ("Horizontal Month Grid =>"+ grid.toString());
  return grid;
}