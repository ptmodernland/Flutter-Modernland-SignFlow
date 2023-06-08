import 'dart:convert';

import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/util/storage/sessionmanager/session_manager.dart';
import 'package:http/http.dart' as http;

import './dto/rekomendasi_waiting_dto.dart';

class RekomendasiRepository {
  Future<ResponseWrapper<String>> giveKoordinasi({
    String noIom = "",
    String idIom = "",
    String comment = "",
    String pin = "",
    String headUsername = "",
  }) async {
    var logTag = "giveKoordinasi";
    try {
      print("trying $logTag");
      var userID = "";
      var usersession = await SessionManager.getUserFromSession();
      if (usersession != null) {
        userID = usersession.idUser;
      }
      // Prepare the request
      var url = Uri.parse(
          'https://approval.modernland.co.id/androidiom/proses_kordinasi.jsp?');

      var body = {
        'nomor': noIom,
        'id_iom': idIom,
        'id_user': userID ?? '',
        'head': headUsername ?? '',
        'komen': comment ?? null,
        'passwordUser': pin ?? '',
      };

      // Set the form data
      print("$logTag" + "SS");

      final stopwatch = Stopwatch()..start();
      var response = await http.post(url, body: body);
      stopwatch.stop();

      if (stopwatch.elapsed.inSeconds < 2) {
        await Future.delayed(Duration(seconds: 3));
      }

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
              "Berhasil Mengirimkan Koordinasi");
        } else {
          return ResponseWrapper(resMessage, ResourceStatus.Error,
              "Gagal Mengirimkan Koordinasi : " + resMessage);
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

  Future<List<RekomendasiWaitingDto>> getWaitingKoordinasi() async {
    var username = "";
    var usersession = await SessionManager.getUserFromSession();
    if (usersession != null) {
      username = usersession.username;
    }
    final url =
        'https://approval.modernland.co.id/androidiom/list_koordinasi_waiting.php?username=$username';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      final approvals =
          jsonData.map((item) => RekomendasiWaitingDto.fromJson(item)).toList();
      return approvals;
    } else {
      throw Exception('Failed to load approvals');
    }
  }

  Future<List<RekomendasiWaitingDto>> getHistoryKoordinasi() async {
    var username = "";
    var usersession = await SessionManager.getUserFromSession();
    if (usersession != null) {
      username = usersession.username;
    }
    final url =
        'https://approval.modernland.co.id/androidiom/list_koordinasi_history.php?username=$username';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      final approvals =
          jsonData.map((item) => RekomendasiWaitingDto.fromJson(item)).toList();
      return approvals;
    } else {
      throw Exception('Failed to load approvals');
    }
  }

  Future<ResponseWrapper<String>> approveKoordinasi({
    String noIom = "",
    String idIom = "",
    String comment = "",
    String pin = "",
    String headUsername = "",
  }) async {
    var logTag = "Approve IOM";
    try {
      print("trying $logTag");
      var userID = "";
      var usersession = await SessionManager.getUserFromSession();
      if (usersession != null) {
        userID = usersession.idUser;
      }
      // Prepare the request
      var url = Uri.parse(
          'https://approval.modernland.co.id/androidiom/proses_approve.jsp?');

      var body = {
        'nomor': noIom,
        'id_iom': idIom,
        'id_user': userID ?? '',
        'head': headUsername ?? '',
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
              "Success", ResourceStatus.Success, "Berhasil Mengapprove");
        } else {
          return ResponseWrapper(resMessage, ResourceStatus.Error,
              "Gagal Approve : " + resMessage);
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
}
