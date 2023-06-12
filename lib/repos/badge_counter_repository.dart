import 'dart:convert';

import 'package:bwa_cozy/bloc/iomcategorycounter/badge_counter_state.dart';
import 'package:bwa_cozy/util/storage/sessionmanager/session_manager.dart';
import 'package:http/http.dart' as http;

class BadgeCounterRepository {
  Future<BadgeCounterState> fetchBadgeCounter() async {
    var username = "";
    final logTag = "badgeCounterState";
    var usersession = await SessionManager.getUserFromSession();
    if (usersession != null) {
      username = usersession.username;
    }
    var url = Uri.parse(
        'https://approval.modernland.co.id/androidiom/counter_kategori.php?username=' +
            username);
    var response = await http.post(url);

    print("getting $logTag");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("$logTag 200 : " + data.toString());

      return BadgeCounterState(
        totalMarketingClub: int.parse(data['total_marketing_club']),
        totalFinance: int.parse(data['total_finance']),
        totalQS: int.parse(data['total_qs']),
        totalLegal: int.parse(data['total_legal']),
        totalPurchasing: int.parse(data['total_purchasing']),
        totalBDD: int.parse(data['total_bdd']),
        totalProject: int.parse(data['total_project']),
        totalPromosi: int.parse(data['total_promosi']),
        totalMarketing: int.parse(data['total_marketing']),
        totalHRD: int.parse(data['total_hrd']),
        totalLanded: int.parse(data['total_landed']),
        totalTown: int.parse(data['total_town']),
        totalPermit: int.parse(data['total_permit']),
        status: data['status'],
      );
    } else {
      print("$logTag thrown : " + "error");
      throw Exception('Failed to fetch badge counter');
    }
  }
}
