import 'package:intl/intl.dart';

String formattedDate(String date) {
  DateTime dateTime = DateTime.parse(date);
  String formattedDate = DateFormat.yMMMd().format(dateTime);
  return formattedDate;
}
