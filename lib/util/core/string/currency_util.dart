import 'package:intl/intl.dart';

String toAbbreviatedNumberString(num? value) {
  if (value == null) return "";

  var f = NumberFormat.compact(locale: "en_US");
  return f.format(value);
}
