class MonthDays {
  static int totalMonthDates = 31;
  static int datePointer = 1;
  static int monthStarter = 0;

  String giveDate() {
    return (datePointer++).toString();
  }
}
