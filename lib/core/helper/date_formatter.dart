import 'package:intl/intl.dart';

String formatDate(int? timestamp) {
  if (timestamp == null) {
    return "-";
  }
  final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('dd MMMM yyyy', 'id_ID').format(date);
}
