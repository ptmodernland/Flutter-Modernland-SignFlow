import 'package:shared_preferences/shared_preferences.dart';

class FilterCompareUtil {
  static const String _startDateKey = 'filter_compare_startDate';
  static const String _endDateKey = 'filter_compare_endDate';
  static const String _queryKey = 'filter_compare_query';

  static Future<void> saveFilterKeys(
      DateTime? startDate, DateTime? endDate, String? query) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (startDate != null) {
      await prefs.setString(_startDateKey, startDate.toIso8601String());
    }
    if (endDate != null) {
      await prefs.setString(_endDateKey, endDate.toIso8601String());
    }
    if (query != null) {
      await prefs.setString(_queryKey, query);
    }
  }

  static Future<DateTime?> getStartDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? startDateString = prefs.getString(_startDateKey);
    return startDateString != null ? DateTime.parse(startDateString) : null;
  }

  static Future<DateTime?> getEndDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? endDateString = prefs.getString(_endDateKey);
    return endDateString != null ? DateTime.parse(endDateString) : null;
  }

  static Future<String?> getQuery() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_queryKey);
  }

  static Future<void> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_startDateKey);
    await prefs.remove(_endDateKey);
    await prefs.remove(_queryKey);
  }

  static Future<void> saveTemporaryFilterKeys(
      DateTime? startDate, DateTime? endDate, String? query) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        '${_startDateKey}_temp', startDate?.toIso8601String() ?? '');
    await prefs.setString(
        '${_endDateKey}_temp', endDate?.toIso8601String() ?? '');
    await prefs.setString('${_queryKey}_temp', query ?? '');
  }

  static Future<DateTime?> getTemporaryStartDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? startDateString = prefs.getString('${_startDateKey}_temp');
    return startDateString != null ? DateTime.parse(startDateString) : null;
  }

  static Future<DateTime?> getTemporaryEndDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? endDateString = prefs.getString('${_endDateKey}_temp');
    return endDateString != null ? DateTime.parse(endDateString) : null;
  }

  static Future<String?> getTemporaryQuery() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('${_queryKey}_temp');
  }

  static Future<void> clearTemporaryFilterKeys() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('${_startDateKey}_temp');
    await prefs.remove('${_endDateKey}_temp');
    await prefs.remove('${_queryKey}_temp');
  }
}
