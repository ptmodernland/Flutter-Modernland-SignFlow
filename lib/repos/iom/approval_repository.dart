import 'dart:convert';

import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/repos/iom/dto/Iom_detail_dto.dart';
import 'package:bwa_cozy/repos/iom/dto/Iom_log_dto.dart';
import 'package:bwa_cozy/repos/iom/dto/approval_item_dto.dart';
import 'package:bwa_cozy/repos/iom/dto/iom_comment_dto.dart';
import 'package:bwa_cozy/util/storage/sessionmanager/session_manager.dart';
import 'package:http/http.dart' as http;

class ApprovalRepository {
  Future<List<ApprovalItem>> getApprovals() async {
    var username = "";
    var usersession = await SessionManager.getUserFromSession();
    if (usersession != null) {
      username = usersession.username;
    }
    final url =
        'https://approval.modernland.co.id/androidiom/list_approve.php?username=$username';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      final approvals =
          jsonData.map((item) => ApprovalItem.fromJson(item)).toList();
      return approvals;
    } else {
      throw Exception('Failed to load approvals');
    }
  }

  Future<List<ApprovalItem>> getByCategory(String divisiId) async {
    var username = "";
    var usersession = await SessionManager.getUserFromSession();
    if (usersession != null) {
      username = usersession.username;
    }
    final url =
        'https://approval.modernland.co.id/androidiom/list_approve_kategori.php?username=$username&divisi_id=$divisiId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      final approvals =
          jsonData.map((item) => ApprovalItem.fromJson(item)).toList();
      return approvals;
    } else {
      throw Exception('Failed to load approvals by category');
    }
  }

  Future<List<ApprovalItem>> getHistory() async {
    var username = "";
    var usersession = await SessionManager.getUserFromSession();
    if (usersession != null) {
      username = usersession.username;
    }
    final url =
        'https://approval.modernland.co.id/androidiom/list_memo_new.php?username=$username';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      final approvals =
          jsonData.map((item) => ApprovalItem.fromJson(item)).toList();
      return approvals;
    } else {
      throw Exception('Failed to load approvals by category');
    }
  }

  Future<List<IomLogDto>> getMemoLog(String idIom) async {
    const url =
        'https://approval.modernland.co.id/androidiom/get_log_memo.php?';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      final approvals =
          jsonData.map((item) => IomLogDto.fromJson(item)).toList();
      return approvals;
    } else {
      throw Exception('Failed to load approvals by category');
    }
  }

  Future<List<IomCommentDto>> getIOMComment(String nomorIom) async {
    final url =
        'https://approval.modernland.co.id/androidiom/get_komen_memo.php?no=$nomorIom';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      final approvals =
          jsonData.map((item) => IomCommentDto.fromJson(item)).toList();
      return approvals;
    } else {
      throw Exception('Failed to load iom comment');
    }
  }

  Future<ResponseWrapper<IomDetailDto>> getDetailIOM(String idIom) async {
    final url =
        'https://approval.modernland.co.id/androidiom/get_memo.php?idiom=$idIom';
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        var responseBody = response.body;
        var jsonResponse = jsonDecode(responseBody);
        final data = IomDetailDto.fromJson(jsonResponse);
        return ResponseWrapper(data, ResourceStatus.Success, "OK");
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, "Error");
      }
    } catch (e) {
      return ResponseWrapper(
          null, ResourceStatus.Error, "Error :" + e.toString());
    }
  }

  Future<ResponseWrapper<String>> approveIom({
    String noIom = "",
    String idIom = "",
    String comment = "",
    String pin = "",
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
              "Success", ResourceStatus.Success, "Berhasil Mengapprove IOM");
        } else {
          return ResponseWrapper(resMessage, ResourceStatus.Error,
              "Gagal Approve IOM : " + resMessage);
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
