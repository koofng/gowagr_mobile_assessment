import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final day = date.day;
  final suffix = _getDaySuffix(day);
  final month = DateFormat.MMM().format(date);
  return '$day$suffix $month';
}

String _getDaySuffix(int day) {
  if (day >= 11 && day <= 13) return 'th';
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}
