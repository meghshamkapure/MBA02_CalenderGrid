
List<dynamic> generateVerticalMonthGrid(int firstWeekday, int totalDays) {
  final List<String> dayLabels = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat'
  ];

  List<dynamic> calendarSlots = List.filled(42, "");

  int date = 1;
  int emptyCells = firstWeekday;
  int x = totalDays - (35 - firstWeekday);

  for (int i = 0; i < calendarSlots.length; i++) {
    int row = i % 7;
    int column = i ~/ 7;
    int index = row * 6 + column;

    if (column == 0) {
      calendarSlots[index] = dayLabels[row];
    } else if (emptyCells > 0) {
      if (x > 0) {
        calendarSlots[index] = totalDays - x + 1;
        --x;
      }
      emptyCells--;
    } else if (date <= totalDays) {
      calendarSlots[index] = date++;
    }
  }
  print ("Vertical Month Grid =>"+ calendarSlots.toString());
  return calendarSlots;
}