import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

enum DateFormatType {
  dayMonthYear,
  weekdayShort,
  weekdayLong,
  dayMonthYearIndonesian,
  weekdayShortIndonesian,
  weekdayLongIndonesian,
}

String mdlnFormatDate(DateTime dateTime, DateFormatType formatType) {
  String formatPattern;
  switch (formatType) {
    case DateFormatType.dayMonthYear:
      formatPattern = 'd MMMM yyyy';
      break;
    case DateFormatType.weekdayShort:
      formatPattern = 'EEE, MMM d, yyyy';
      break;
    case DateFormatType.weekdayLong:
      formatPattern = 'EEEE, MMMM d, yyyy';
      break;
    case DateFormatType.dayMonthYearIndonesian:
      formatPattern = 'd MMMM yyyy';
      break;
    case DateFormatType.weekdayShortIndonesian:
      formatPattern = 'EEE, d MMMM yyyy';
      break;
    case DateFormatType.weekdayLongIndonesian:
      formatPattern = 'EEEE, d MMMM yyyy';
      break;
    default:
      throw Exception('Invalid DateFormatType');
  }
  initializeDateFormatting();

  final formatter = DateFormat(formatPattern, 'id_ID');
  return formatter.format(dateTime);
}
