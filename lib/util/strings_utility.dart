class StringsUtility{

  static String dateToString(DateTime date) {
    return date.day.toString() +
        '.' +
        date.month.toString() +
        '.' +
        (date.year.toString()).substring(2);
  }
}