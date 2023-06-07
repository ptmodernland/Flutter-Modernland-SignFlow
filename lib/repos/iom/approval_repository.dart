import 'dart:convert';

import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/repos/iom/dto/Iom_detail_dto.dart';
import 'package:bwa_cozy/repos/iom/dto/approval_item_dto.dart';
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
}
