import 'package:intl/intl.dart';

class DateFormatter {
  /// Formats a [DateTime] object to a human-readable string.
  static String formatDate(DateTime date, {String format = 'yyyy/MM/dd'}) {
    return DateFormat(format).format(date);
  }

  /// Parses a string into a [DateTime] object based on the given [format].
  static DateTime parseDate(String dateString, {String format = 'yyyy/MM/dd'}) {
    return DateFormat(format).parse(dateString);
  }

  /// Returns the current date formatted as per the given [format].
  static String getCurrentDate({String format = 'yyyy/MM/dd'}) {
    return DateFormat(format).format(DateTime.now());
  }

  /// Formats a timestamp (milliseconds since epoch) into a human-readable date.
  static String formatTimestamp(int timestamp, {String format = 'yyyy/MM/dd'}) {
    return DateFormat(format).format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }
}
