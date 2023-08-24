import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:intl/intl.dart';

String formatTime(String inputString) {
  /// Convert into local date format.
  var localDate = DateTime.parse(inputString).toLocal();

  /// inputFormat - format getting from api or other func.
  /// e.g If 2021-05-27 9:34:12.781341 then format should be yyyy-MM-dd HH:mm
  /// If 27/05/2021 9:34:12.781341 then format should be dd/MM/yyyy HH:mm
  var inputFormat = DateFormat(AppStrings.formatDateTime);
  var inputDate = inputFormat.parse(localDate.toString());

  /// outputFormat - convert into format you want to show.
  var outputFormat = DateFormat(AppStrings.formatDateTime);
  var outputDate = outputFormat.format(inputDate);

  return outputDate.toString();
}
