import 'package:intl/intl.dart';

String custformatDate(DateTime date) {
  return DateFormat('dd/MM/yyyy hh:mm a').format(date);
}
