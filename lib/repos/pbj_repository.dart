import 'dart:convert';

import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/bloc/all_approval/dto/list_all_pbj_dto.dart';
import 'package:bwa_cozy/util/storage/sessionmanager/session_manager.dart';
import 'package:http/http.dart' as http;

class PBJRepository {
  //use this to approve a PBJ
  Future<ResponseWrapper<String>> approvePBJ({
    String noPermintaan = "",
    String comment = "",
    String pin = "",
  }) async {
    var logTag = "Approve PBJ";
    try {
      print("trying $logTag");
      var userID = "";
      var usersession = await SessionManager.getUserFromSession();
      if (usersession != null) {
        userID = usersession.idUser;
      }
      // Prepare the request
      var url = Uri.parse(
          'https://approval.modernland.co.id/androidiom/proses_approve_pbj.jsp?' +
              userID);

      var body = {
        'no_permintaan': noPermintaan,
        'id_user': userID ?? '',
        'komenad': comment ?? null,
        'passwordUser': pin ?? '',
      };

      // Set the form data
      print("$logTag" + "SS");
      var response = await http.post(url, body: body);
      var responseBody = response.body;
      var jsonResponse = jsonDecode(responseBody);
      bool resStatus = jsonResponse['status'];
      var resMessage = jsonResponse['pesan'];
      final result = jsonDecode(response.body);
      print(result.toString());
      if (response.statusCode == 200) {
        print("result $logTag 200");
        if (resStatus) {
          return ResponseWrapper(
              "Success", ResourceStatus.Success, "Berhasil Mengapprove PBJ");
        } else {
          return ResponseWrapper(resMessage, ResourceStatus.Error,
              "Gagal Approve PBJ : " + resMessage);
        }
      } else {
        print("result $logTag Terjadi Kesalahan");
        return ResponseWrapper(null, ResourceStatus.Error, resMessage);
      }
    } catch (error) {
      print("error on $logTag " + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  //use this to REJECT a PBJ
  Future<ResponseWrapper<String>> rejectPBJ({
    String noPermintaan = "",
    String comment = "",
    String pin = "",
  }) async {
    var logTag = "Reject PBJ";
    try {
      print("trying $logTag");
      var userID = "";
      var usersession = await SessionManager.getUserFromSession();
      if (usersession != null) {
        userID = usersession.idUser;
      }
      // Prepare the request
      var url = Uri.parse(
          'https://approval.modernland.co.id/androidiom/proses_cancel_pbj.jsp?' +
              userID);

      var body = {
        'no_permintaan': noPermintaan,
        'id_user': userID ?? '',
        'komenad': comment ?? null,
        'passwordUser': pin ?? '',
      };

      // Set the form data
      print("$logTag" + "SS");
      var response = await http.post(url, body: body);
      var responseBody = response.body;
      var jsonResponse = jsonDecode(responseBody);
      bool resStatus = jsonResponse['status'];
      var resMessage = jsonResponse['pesan'];
      final result = jsonDecode(response.body);
      print(result.toString());
      if (response.statusCode == 200) {
        print("result $logTag 200");
        if (resStatus) {
          return ResponseWrapper(
              "Success", ResourceStatus.Success, "PBJ Berhasil Direject");
        } else {
          return ResponseWrapper(resMessage, ResourceStatus.Error,
              "Gagal Reject PBJ : " + resMessage);
        }
      } else {
        print("result $logTag Terjadi Kesalahan");
        return ResponseWrapper(null, ResourceStatus.Error, resMessage);
      }
    } catch (error) {
      print("error on $logTag " + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  Future<ResponseWrapper<List<ListAllPbjDTO>>> getHistoryPBJ(
      {String? startDate = null,
      String? endDate = null,
      String? year = null,
      String? noPermintaan = null,
      bool isAll = true}) async {
    var logTag = "Getting PBJ";
    try {
      print("trying getting PBJ");
      var username = "";
      var usersession = await SessionManager.getUserFromSession();

      if (usersession != null) {
        username = usersession.username;
      }
      // Prepare the request
      var url = Uri.parse(
          'https://approval.modernland.co.id/androidiom/list_pbj_new.php?username=' +
              username);
      // Set the form data
      print("URL History PBJ");

      print("$logTag" + "SS");
      // Send the request
      var response = await http.post(url);
      // Get the response body as a string
      var responseBody = response.body;
      // print("$logTag : $responseBody");
      var jsonResponse = jsonDecode(responseBody);
      // Extract the code and message fields
      final result = jsonDecode(response.body);
      print(result.toString());
      if (response.statusCode == 200) {
        print("result 200");
        final jsonData = json.decode(response.body);
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(jsonData);
        final List<ListAllPbjDTO> datas =
            dataList.map((data) => ListAllPbjDTO.fromJson(data)).toList();
        // Now you have the list of `Bottle` objects
        return ResponseWrapper(datas, ResourceStatus.Success, "Success");
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
      }
    } catch (error) {
      print("error on ApprovalMainPageRepository " + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
    return ResponseWrapper(null, ResourceStatus.Success, "Login Berhasil");
  }
}
