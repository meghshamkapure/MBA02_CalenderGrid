List<String> generateHorizontalMonthGrid(int monthStartsOn, int daysInMonth) {
  const List<String> weekdayLabels = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat'
  ];

  List<String> calendarGrid = List<String>.filled(42, '');

  int currentDate = 1;
  int remainingEmptyCells = monthStartsOn % 7;

  for (int gridIndex = 0; gridIndex < calendarGrid.length;) {
    // Fill first row with weekday labels
    if (gridIndex <= 6) {
      calendarGrid[gridIndex] = weekdayLabels[gridIndex % 7];
    }
    // Fill empty cells before the month starts
    else if (gridIndex > 6 && remainingEmptyCells-- > 0) {
      calendarGrid[gridIndex] = '';
    }
    // Fill actual days of the month
    else if (gridIndex > 6 && currentDate <= daysInMonth) {
      calendarGrid[gridIndex] = (currentDate++).toString();
    }

    gridIndex++;

    // Restart from position 7 if dates are left and grid is filled
    if (currentDate <= daysInMonth && gridIndex == calendarGrid.length) {
      gridIndex = weekdayLabels.length;
    }
  }

  print("Horizontal Month Grid => $calendarGrid");
  return calendarGrid;
}