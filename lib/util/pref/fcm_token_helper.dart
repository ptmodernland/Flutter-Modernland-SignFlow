import 'package:shared_preferences/shared_preferences.dart';

Future<String> getDeviceFCMToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String deviceToken = prefs.getString('deviceToken') ?? '';
  return deviceToken;
}
