List<dynamic> generateVerticalMonthGrid(int firstWeekday, int totalDays) {
  final List<String> weekdayLabels = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat'
  ];

  List<dynamic> verticalCalendarGrid = List.filled(42, "");

  int currentDate = 1;
  int remainingEmptyCells = firstWeekday;
  int overflowDays = totalDays - (35 - firstWeekday);

  for (int linearIndex = 0; linearIndex < verticalCalendarGrid.length; linearIndex++) {
    int rowIndex = linearIndex % 7;
    int columnIndex = linearIndex ~/ 7;
    int gridPosition = rowIndex * 6 + columnIndex;

    // Fill first column with weekday labels
    if (columnIndex == 0) {
      verticalCalendarGrid[gridPosition] = weekdayLabels[rowIndex];
    }
    // Fill empty cells with overflow days from previous month
    else if (remainingEmptyCells > 0) {
      if (overflowDays > 0) {
        verticalCalendarGrid[gridPosition] = totalDays - overflowDays + 1;
        --overflowDays;
      }
      remainingEmptyCells--;
    }
    // Fill actual days of the current month
    else if (currentDate <= totalDays) {
      verticalCalendarGrid[gridPosition] = currentDate++;
    }
  }

  print("Vertical Month Grid => $verticalCalendarGrid");
  return verticalCalendarGrid;
}