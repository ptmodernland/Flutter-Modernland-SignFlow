import 'dart:math';

import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/bloc/login/login_payload.dart';
import 'package:bwa_cozy/bloc/login/login_response.dart';
import 'package:bwa_cozy/bloc/notif/notif_counter_dto.dart';
import 'package:bwa_cozy/util/storage/sessionmanager/session_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotifRepository {
  Future<ResponseWrapper<NotifCounterDTO>> countNotif() async {
    try {

      var username = "";
      var usersession = await SessionManager.getUserFromSession();

      if(usersession!=null){
        username = usersession.username;
      }
      // Prepare the request
      var url = Uri.parse('https://approval.modernland.co.id/androidiom/counter_all.php?username='+username);
      // Set the form data
      print("getNotifLog Username " + username);
      // Send the request
      var response = await http.get(url);
      // Get the response body as a string
      var responseBody = response.body;
      print("168_notifLog_code: " + response.statusCode.toString());
      print("168_notifLog_response: $responseBody");
      var jsonResponse = jsonDecode(responseBody);
      // Extract the code and message fields
      bool resStatus = jsonResponse['status'];
      print("168_notifLog_resStatus: $resStatus");
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("resStatus : " + resStatus.toString());
        if (resStatus) {
          var notifCounter = NotifCounterDTO.fromJson(result);
          print("notifCounterDTO : " + notifCounter.toString());
          return ResponseWrapper(
              notifCounter, ResourceStatus.Success, "Login Berhasil");
        } else {
          print("notifCounterDTOError : " + responseBody);
          return ResponseWrapper(null, ResourceStatus.Error, null);
        }
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, null);
      }
    }
    catch (error) {
      print("error on NotifRepository "+error.toString());
      throw Exception('An error occurred ' + error.toString());
    }
  }


}
