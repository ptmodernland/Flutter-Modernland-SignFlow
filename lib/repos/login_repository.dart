import 'package:bwa_cozy/bloc/login/login_payload.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginRepository {
  Future<bool> login(LoginPayload payload) async {
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
      print("loginLog Username "+payload.username);
      print("loginLog Password "+payload.password);
      // Send the request
      var response = await http.post(url, body: body);
      // Get the response body as a string
      var responseBody = response.body;
      print("168_login_response: $responseBody");
      var jsonResponse = jsonDecode(responseBody);
      // Extract the code and message fields
      var resCode = jsonResponse['code'];
      bool resStatus = jsonResponse['status'];
      var resMessage = jsonResponse['message'];

      if (response.statusCode == 200) {

        if(resStatus){
          return true;
        }else{
          return false;
        }

      } else {
        return false;
      }
    } catch (error) {
      throw Exception('An error occurred');
    }
  }
}