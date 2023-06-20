import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/bloc/login/login_payload.dart';
import 'package:bwa_cozy/bloc/login/login_response.dart';
import 'package:bwa_cozy/data/dio_client.dart';
import 'package:bwa_cozy/util/pref/fcm_token_helper.dart';
import 'package:bwa_cozy/util/storage/sessionmanager/session_manager.dart';
import 'package:dio/dio.dart';

class LoginRepository {
  final DioClient dioClient;

  LoginRepository({required this.dioClient});

  Future<ResponseWrapper<UserDTO>> login(LoginPayload payload) async {
    try {
      var token = await getDeviceFCMToken();

      var formData = FormData.fromMap({
        'username': payload.username,
        'password': payload.password,
        'token': token,
        'address': payload.address,
        'ip': payload.ip,
        'brand': "iPhone",
        'model': "(Flutter) " + payload.model,
        'phonetype': payload.phonetype,
        'proses': 'cek_login'
      });

      var dioResponse = await dioClient
          .post("androidiom/flutter_proses_login.jsp", data: formData);

      print("loginLog Username " + payload.username);
      print("loginLog Password " + payload.password);
      print("168_login_code: " + dioResponse.statusCode.toString());
      print("168_login_response: ${dioResponse.data}");

      var jsonResponse = dioResponse.data;
      bool resStatus = jsonResponse['status'];
      var resMessage = jsonResponse['pesan'];

      if (dioResponse.statusCode == 200) {
        print("resStatus : " + resStatus.toString());
        if (resStatus) {
          var user = UserDTO.fromJson(jsonResponse);
          print("userDTO : " + user.toString());
          SessionManager.saveUser(user);
          return ResponseWrapper(
              user, ResourceStatus.Success, "Login Berhasil");
        } else {
          return ResponseWrapper(null, ResourceStatus.Error, resMessage);
        }
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, resMessage);
      }
    } catch (error, stackTrace) {
      throw Exception('An error occurred ' +
          error.toString() +
          "\nStack Trace : " +
          stackTrace.toString());
    }
  }

  Future<ResponseWrapper<bool>> unbindDevice(String username) async {
    try {
      var formData = FormData.fromMap({
        'username': username,
      });

      var dioResponse = await dioClient.post(
        'https://approval.modernland.co.id/androidiom/proses_logout.php',
        data: formData,
      );

      print("logoutLog Username " + username);
      print("168_login_code: " + dioResponse.statusCode.toString());
      print("168_login_response: ${dioResponse.data}");

      var jsonResponse = dioResponse.data;
      bool resStatus = jsonResponse['status'];
      var resMessage = jsonResponse['pesan'];

      if (dioResponse.statusCode == 200) {
        print("resStatus : " + resStatus.toString());
        if (resStatus) {
          SessionManager.removeUser();
          return ResponseWrapper(
              true, ResourceStatus.Success, "Logout Berhasil");
        } else {
          return ResponseWrapper(null, ResourceStatus.Error, resMessage);
        }
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, resMessage);
      }
    } catch (error) {
      throw Exception('An error occurred ' + error.toString());
    }
  }

  Future<ResponseWrapper<bool>> changePinPassword({String? password, String? newPassword, String? pin}) async {
    try {
      var user = await SessionManager.getUser();
      print("bloc reset password for " + user.toString());
      if (user != null) {
        var formData = FormData.fromMap({
          'id_user': user.idUser,
          'password': password ?? '',
          'confirm_password': newPassword ?? '',
          'pin': pin ?? '',
        });

        var dioResponse = await dioClient.post(
          'https://approval.modernland.co.id/androidiom/proses_change_password.php',
          data: formData,
        );

        print(
            "bloc 168_change_pass_code: " + dioResponse.statusCode.toString());
        print("bloc 168_change_pass_response: ${dioResponse.data}");

        var jsonResponse = dioResponse.data;
        bool resStatus = jsonResponse['status'];
        var resMessage = jsonResponse['pesan'];

        if (dioResponse.statusCode == 200) {
          print("bloc resStatus: $resStatus");
          if (resStatus) {
            return ResponseWrapper(
                true, ResourceStatus.Success, "Berhasil Mengganti Password");
          } else {
            print("bloc userDTOError: $jsonResponse");
            return ResponseWrapper(null, ResourceStatus.Error, resMessage);
          }
        } else {
          return ResponseWrapper(null, ResourceStatus.Error, "okeoke");
        }
      }
    } catch (error) {
      print("bloc change password error: " + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
    print("change password error?: ");
    return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
  }
}
