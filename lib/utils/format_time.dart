import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String formatTime(String inputString) {
  initializeDateFormatting();

  var localDate = DateTime.parse(inputString).toLocal();
  return DateFormat(AppStrings.formatDateTime).format(localDate);
}

String customFormatTime(String inputString, String pattern) {
  initializeDateFormatting();

  var localDate = DateTime.parse(inputString).toLocal();
  return DateFormat(pattern).format(localDate);
}
