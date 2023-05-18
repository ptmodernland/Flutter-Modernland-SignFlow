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
        print("resStatus : "+resStatus.toString());
        if (resStatus) {
          var user = UserDTO.fromJson(result);
          print("userDTO : "+user.toString());
          SessionManager.saveUser(user);
          return ResponseWrapper(user, ResourceStatus.Success, "Login Berhasil");
        } else {
          print("userDTOError : "+responseBody);
          return ResponseWrapper(null, ResourceStatus.Error, resMessage);
        }
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, resMessage);
      }
    } catch (error) {
      throw Exception('An error occurred '+error.toString());
    }
  }
}
