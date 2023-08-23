class DatetimeConverter {
  static DateTime fromShortString(String value) {
    final List<String> date = value.split(RegExp(r'/'));
    final int month = int.parse(date.first);
    final int year = int.parse('20${date.last}');
    final int lastDayOfMonth = month < 12
        ? DateTime(year, month + 1, 0).day
        : DateTime(year + 1, 1, 0).day;

    return DateTime(year, month, lastDayOfMonth, 23, 59, 59, 999);
  }
}
