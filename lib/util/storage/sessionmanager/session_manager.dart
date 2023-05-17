import 'dart:convert';
import 'package:bwa_cozy/bloc/login/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _userKey = 'user';

  static Future<void> saveUser(UserDTO user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userJson = json.encode(user.toJson());
    await prefs.setString(_userKey, userJson);
  }

  static Future<UserDTO?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString(_userKey);
    if (userJson != null) {
      final Map<String, dynamic> userMap = json.decode(userJson);
      return UserDTO.fromJson(userMap);
    }
    return null;
  }

  static Future<void> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  static Future<void> saveUserInSession(UserDTO user) async {
    await SessionManager.saveUser(user);
    print('User saved in session.');
  }

  static Future<UserDTO?> getUserFromSession() async {
    UserDTO? savedUser = await SessionManager.getUser();
    if (savedUser != null) {
      print('Retrieved User:');
      print(savedUser.idUser);
      print(savedUser.username);
      print(savedUser.nama);
      print(savedUser.level);
      print(savedUser.email);
      print(savedUser.jk);
      print(savedUser.status);
    } else {
      print('User not found in session.');
    }
    return savedUser;
  }

  static Future<void> removeUserFromSession() async {
    await SessionManager.removeUser();
    print('User removed from session.');
  }
}
