import 'package:intl/intl.dart';

class DateUtilsC {
  // Format a DateTime object to a string with the format yyyy/MM/dd
  static String formatDate(DateTime date) {
    return DateFormat('yyyy/MM/dd').format(date);
  }

  // Convert a string in the format "yyyy-MM-ddTHH:mm:ss.sssZ" to "yyyy/MM/dd"
  static String formatDateString(String dateString) {
    try {
      DateTime dateTime =
          DateTime.parse(dateString).toLocal(); // Convert to DateTime
      return formatDate(dateTime);
    } catch (e) {
      return 'Invalid date'; // Handle invalid date format
    }
  }
}
