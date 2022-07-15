import 'package:intl/intl.dart';

class DatetimeConverter {
  static DateTime fromShortString(String value) {
    return DateFormat('MM/yy').parse(value);
  }
}
