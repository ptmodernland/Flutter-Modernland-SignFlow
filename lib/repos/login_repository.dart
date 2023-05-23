import 'dart:math';

import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/bloc/login/login_payload.dart';
import 'package:bwa_cozy/bloc/login/login_response.dart';
import 'package:bwa_cozy/util/storage/sessionmanager/session_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginRepository {
  Future<ResponseWrapper<UserDTO>> login(LoginPayload payload) async {
    try {
      // Prepare the request
      var url = Uri.parse('https://api-approval.modernland.co.id/login.jsp');
      // Set the form data
      var body = {
        'username': payload.username,
        'password': payload.password,
        'token': payload.token,
        'address': payload.address,
        'ip': payload.ip,
        'brand': payload.brand,
        'model': payload.model,
        'phonetype': payload.phonetype,
        'proses': 'cek_login'
      };
      print("loginLog Username " + payload.username);
      print("loginLog Password " + payload.password);
      // Send the request
      var response = await http.post(url, body: body);
      // Get the response body as a string
      var responseBody = response.body;
      print("168_login_code: " + response.statusCode.toString());
      print("168_login_response: $responseBody");
      var jsonResponse = jsonDecode(responseBody);
      // Extract the code and message fields
      bool resStatus = jsonResponse['status'];
      var resMessage = jsonResponse['pesan'];

      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("resStatus : " + resStatus.toString());
        if (resStatus) {
          var user = UserDTO.fromJson(result);
          print("userDTO : " + user.toString());
          SessionManager.saveUser(user);
          return ResponseWrapper(
              user, ResourceStatus.Success, "Login Berhasil");
        } else {
          print("userDTOError : " + responseBody);
          return ResponseWrapper(null, ResourceStatus.Error, resMessage);
        }
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, resMessage);
      }
    } catch (error) {
      throw Exception('An error occurred ' + error.toString());
    }
  }

  Future<ResponseWrapper<bool>> unbindDevice(String username) async {
    try {
      // Prepare the request
      var url = Uri.parse(
          'https://approval.modernland.co.id/androidiom/proses_logout.php');
      // Set the form data
      var body = {
        'username': username,
      };
      print("logoutLog Username " + username);
      // Send the request
      var response = await http.post(url, body: body);
      // Get the response body as a string
      var responseBody = response.body;
      print("168_login_code: " + response.statusCode.toString());
      print("168_login_response: $responseBody");
      var jsonResponse = jsonDecode(responseBody);
      // Extract the code and message fields
      bool resStatus = jsonResponse['status'];
      var resMessage = jsonResponse['pesan'];

      final result = jsonDecode(response.body);
      print(result.toString());

      if (response.statusCode == 200) {
        print("resStatus : " + resStatus.toString());
        if (resStatus) {
          SessionManager.removeUser();
          return ResponseWrapper(
              true, ResourceStatus.Success, "Logout Berhasil");
        } else {
          print("userDTOError : " + responseBody);
          return ResponseWrapper(null, ResourceStatus.Error, resMessage);
        }
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, resMessage);
      }
    } catch (error) {
      throw Exception('An error occurred ' + error.toString());
    }
  }

  Future<ResponseWrapper<bool>> changePinPassword(
      {String? password, String? newPassword, String? pin}) async {
    try {
      var url = Uri.parse('https://approval.modernland.co.id/androidiom/proses_change_password.php');
      var user = await SessionManager.getUser();
      print("bloc reset password for " +user.toString());
      if (user != null) {
        var body = {
          'id_user': user.idUser,
          'password': password ?? '',
          'confirm_password': newPassword ?? '',
          'pin': pin ?? '',
        };

        var response = await http.post(url, body: body);
        var responseBody = response.body;
        print("bloc 168_change_pass_code: " + response.statusCode.toString());
        print("bloc 168_change_pass_response: $responseBody");

        var jsonResponse = jsonDecode(responseBody);
        bool resStatus = jsonResponse['status'];
        var resMessage = jsonResponse['pesan'];
        if (response.statusCode == 200) {
          print("bloc resStatus: $resStatus");
          if (resStatus) {
            return ResponseWrapper(
                true, ResourceStatus.Success, "Berhasil Mengganti Password");
          } else {
            print("bloc userDTOError: $responseBody");
            return ResponseWrapper(null, ResourceStatus.Error, resMessage);
          }
        } else {
          return ResponseWrapper(null, ResourceStatus.Error, "okeoke");
        }
      }
    } catch (error) {
      print("bloc change password error: "+error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
    print("change password error?: ");
    return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
  }
}
