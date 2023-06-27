import 'package:modernland_signflow/bloc/iomcategorycounter/badge_counter_state.dart';
import 'package:modernland_signflow/data/dio_client.dart';
import 'package:modernland_signflow/util/storage/sessionmanager/session_manager.dart';

class BadgeCounterRepository {
  DioClient dioClient;

  BadgeCounterRepository({required this.dioClient});

  Future<BadgeCounterState> fetchBadgeCounter() async {
    var username = "";
    final logTag = "badgeCounterState";
    var usersession = await SessionManager.getUserFromSession();
    if (usersession != null) {
      username = usersession.username;
    }
    var url =
        'https://approval.modernland.co.id/androidiom/counter_kategori.php?username=$username';

    try {
      print("getting $logTag");

      // Send the request
      var response = await dioClient.post(url);

      if (response.statusCode == 200) {
        final data = response.data;
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
    } catch (error) {
      print("error on $logTag: $error");
      throw Exception('Failed to fetch badge counter: $error');
    }
  }
}
