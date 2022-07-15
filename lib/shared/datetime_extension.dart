extension DateTimeExtension on DateTime {
  bool isSameYM(DateTime other) {
    return year == other.year && month == other.month;
  }
}
