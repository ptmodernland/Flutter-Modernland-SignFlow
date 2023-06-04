import 'dart:convert';

import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/bloc/compare/dto/detail_compare_dto.dart';
import 'package:bwa_cozy/bloc/kasbon/dto/KasbonCommentDTO.dart';
import 'package:bwa_cozy/bloc/kasbon/dto/KasbonDetailDTO.dart';
import 'package:bwa_cozy/bloc/kasbon/dto/ListAllKasbonDTO.dart';
import 'package:bwa_cozy/bloc/pbj/dto/ListPBJDTO.dart';
import 'package:bwa_cozy/bloc/pbj/dto/list_komen_pbj.dart';
import 'package:bwa_cozy/util/storage/sessionmanager/session_manager.dart';
import 'package:http/http.dart' as http;

class KasbonRepository {
  //use this to approve a PBJ
  Future<ResponseWrapper<String>> approveKasbon({
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
          'https://approval.modernland.co.id/androidiom/proses_approve_kasbon.jsp?' +
              userID);

      var body = {
        'noKasbon': noPermintaan,
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

  //use this to REJECT a kasbon
  Future<ResponseWrapper<String>> rejectKasbon({
    String noPermintaan = "",
    String comment = "",
    String pin = "",
  }) async {
    var logTag = "Reject Kasbon";
    try {
      print("trying $logTag");
      var userID = "";
      var usersession = await SessionManager.getUserFromSession();
      if (usersession != null) {
        userID = usersession.idUser;
      }
      // Prepare the request
      var url = Uri.parse(
          'https://approval.modernland.co.id/androidiom/proses_cancel_kasbon.jsp?' +
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

  Future<ResponseWrapper<List<ListAllKasbonDto>>> getHistoryKasbon(
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
          'https://approval.modernland.co.id/androidiom/list_kasbon.php?username=' +
              username);
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
        print("168 result 200");
        final jsonData = json.decode(response.body);
        final dataList = List<Map<String, dynamic>>.from(jsonData);
        final datas =
            dataList.map((data) => ListAllKasbonDto.fromJson(data)).toList();
        print("168 success siii");
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

  Future<ResponseWrapper<List<KasbonCommentDto>>> getKomentarKasbon(
      {String? noPermintaan = null}) async {
    var logTag = "Getting PBJ Komentar";
    try {
      print("trying getting $logTag $noPermintaan");
      // Prepare the request
      var url = Uri.parse(
          'https://approval.modernland.co.id/androidiom/get_komen_kasbon.php?no_kasbon=' +
              noPermintaan.toString());
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
        print("result $logTag 200");
        final jsonData = json.decode(response.body);
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(jsonData);
        final List<KasbonCommentDto> datas =
            dataList.map((data) => KasbonCommentDto.fromJson(data)).toList();
        // Now you have the list of `Bottle` objects
        print("komentar $logTag success $jsonData");
        return ResponseWrapper(datas, ResourceStatus.Success, "Success");
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
      }
    } catch (error) {
      print("error on $logTag " + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
    return ResponseWrapper(null, ResourceStatus.Success, "Login Berhasil");
  }

  //use this to see Kasbon Detail
  Future<ResponseWrapper<KasbonDetailDto>> getKasbonDetail(
      String noKasbon) async {
    var logTag = "Getting Detail Kasbon";
    try {
      print("trying to $logTag");
      // Prepare the request
      var url = Uri.parse(
          'https://approval.modernland.co.id/androidiom/get_kasbon.php?noKasbon=' +
              noKasbon);
      // Send the request
      var response = await http.post(url);
      // Get the response body as a string
      var responseBody = response.body;
      print("$logTag : $responseBody");
      var jsonResponse = jsonDecode(responseBody);

      if (response.statusCode == 200) {
        print("result $logTag 200");
        final data = KasbonDetailDto.fromJson(jsonResponse);
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
