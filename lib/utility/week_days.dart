class WeekDays {
  static int dayPointer = 0;

  String giveDay() {
    const List<String> weekdays = [
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
    ];
    if (dayPointer > 6) {
      dayPointer = dayPointer % 7;
    }
    return weekdays[dayPointer++];
  }
}
