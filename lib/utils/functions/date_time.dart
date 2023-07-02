import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays >= 2) {
    return DateFormat.MMMd().format(dateTime);
  } else if (difference.inDays == 1) {
    return '1 Day ago';
  } else if (difference.inHours >= 1) {
    return '${difference.inHours} hours ago';
  } else if (difference.inMinutes >= 1) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inSeconds >= 5) {
    return '${difference.inSeconds} seconds ago';
  } else if (difference.inSeconds < 5 && difference.inSeconds >= 0) {
    return 'just now';
  } else {
    return 'Post from future';
  }
}