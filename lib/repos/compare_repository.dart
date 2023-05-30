import 'dart:convert';

import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/bloc/all_approval/dto/list_all_compare_dto.dart';
import 'package:bwa_cozy/bloc/compare/dto/detail_compare_dto.dart';
import 'package:bwa_cozy/bloc/pbj/dto/list_komen_pbj.dart';
import 'package:bwa_cozy/util/storage/sessionmanager/session_manager.dart';
import 'package:http/http.dart' as http;

class CompareRepository {
  //use this to approve a PBJ
  Future<ResponseWrapper<String>> approveCompare({
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
          'https://approval.modernland.co.id/androidiom/proses_approve_compare.jsp?' +
              userID);

      var body = {
        'nomor': noPermintaan,
        'id_user': userID ?? '',
        'komen': comment ?? null,
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
          return ResponseWrapper("Success", ResourceStatus.Success,
              "Berhasil Mengapprove Comparison");
        } else {
          return ResponseWrapper(resMessage, ResourceStatus.Error,
              "Gagal Approve Comparison : " + resMessage);
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

  //use this to REJECT
  Future<ResponseWrapper<String>> rejectCompare({
    String noPermintaan = "",
    String comment = "",
    String pin = "",
  }) async {
    var logTag = "Reject Compare";
    try {
      print("trying $logTag");
      var userID = "";
      var usersession = await SessionManager.getUserFromSession();
      if (usersession != null) {
        userID = usersession.idUser;
      }
      // Prepare the request
      var url = Uri.parse(
          'https://approval.modernland.co.id/androidiom/proses_cancel_compare.jsp?' +
              userID);

      var body = {
        'nomor': noPermintaan,
        'id_user': userID ?? '',
        'komen': comment ?? null,
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
              "Success", ResourceStatus.Success, "Compare Berhasil Direject");
        } else {
          return ResponseWrapper(resMessage, ResourceStatus.Error,
              "Gagal Reject Compare : " + resMessage);
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

  Future<ResponseWrapper<List<ListAllCompareDTO>>> getHistoryCompare(
      {String? startDate = null,
      String? endDate = null,
      String? year = null,
      String? noPermintaan = null,
      bool isAll = true}) async {
    var logTag = "Getting Compare";
    try {
      print("trying getting Compare");
      var username = "";
      var usersession = await SessionManager.getUserFromSession();

      if (usersession != null) {
        username = usersession.username;
      }
      // Prepare the request
      var url = Uri.parse(
          'https://approval.modernland.co.id/androidiom/list_compare_new.php?username=' +
              username);
      // Set the form data
      print("URL History PBJ");
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
        final List<ListAllCompareDTO> datas =
            dataList.map((data) => ListAllCompareDTO.fromJson(data)).toList();
        // Now you have the list of `Bottle` objects
        return ResponseWrapper(datas, ResourceStatus.Success, "Success");
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
      }
    } catch (error) {
      print("error on CompareRepository " + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
    return ResponseWrapper(null, ResourceStatus.Success, "Login Berhasil");
  }

  Future<ResponseWrapper<List<ListPBJCommentDTO>>> getCommentCompare(
      {String? noCompare = null}) async {
    var logTag = "Getting Compare Comment";
    try {
      print("trying getting $logTag");
      // Prepare the request
      var url = Uri.parse(
          'https://approval.modernland.co.id/androidiom/get_komen_compare.php?no_compare=' +
              noCompare.toString());
      // Set the form data
      var response = await http.get(url);
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
        final List<ListPBJCommentDTO> datas =
            dataList.map((data) => ListPBJCommentDTO.fromJson(data)).toList();
        // Now you have the list of `Bottle` objects
        return ResponseWrapper(datas, ResourceStatus.Success, "Success");
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
      }
    } catch (error) {
      print("error on $logTag " + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  //use this to see PBJ Detail
  Future<ResponseWrapper<DetailCompareDTO>> getCompareDetail(
      String idPermintaan) async {
    var logTag = "Getting Detail Compare";
    try {
      print("trying to get Compare detail");
      // Prepare the request
      var url = Uri.parse(
          'https://approval.modernland.co.id/androidiom/get_compare.php?idcompare=' +
              idPermintaan);
      // Send the request
      var response = await http.post(url);
      // Get the response body as a string
      var responseBody = response.body;
      print("$logTag : $responseBody");
      var jsonResponse = jsonDecode(responseBody);

      if (response.statusCode == 200) {
        print("result $logTag 200");
        final DetailCompareDTO data = DetailCompareDTO.fromJson(jsonResponse);

        print("result $logTag success");
        return ResponseWrapper(data, ResourceStatus.Success, "Success");
      } else {
        print("result $logTag encountered an error");
        return ResponseWrapper(null, ResourceStatus.Error, "An error occurred");
      }
    } catch (error) {
      print("error on $logTag: $error");
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }
}
