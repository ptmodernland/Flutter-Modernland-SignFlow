import 'package:modernland_signflow/bloc/_wrapper/response_wrapper.dart';
import 'package:modernland_signflow/bloc/notif/notif_counter_dto.dart';
import 'package:modernland_signflow/data/dio_client.dart';
import 'package:modernland_signflow/util/storage/sessionmanager/session_manager.dart';

class NotifRepository {
  DioClient dioClient;

  NotifRepository({required this.dioClient});

  Future<ResponseWrapper<NotifCounterDTO>> countNotif() async {
    try {
      var username = "";
      var usersession = await SessionManager.getUserFromSession();

      if (usersession != null) {
        username = usersession.username;
      }

      // Prepare the request URL
      var url = 'androidiom/flutter_counter_all.php?username=$username';

      // Send the request using Dio
      var dioResponse = await dioClient.get(url);

      print("getNotifLog Username $username");
      print("168_notifLog_code: ${dioResponse.statusCode}");
      print("168_notifLog_response: ${dioResponse.data}");

      var jsonResponse = dioResponse.data;
      bool resStatus = jsonResponse['status'];
      print("168_notifLog_resStatus: $resStatus");

      if (dioResponse.statusCode == 200) {
        print("resStatus: $resStatus");
        if (resStatus) {
          var notifCounter = NotifCounterDTO.fromJson(jsonResponse);
          print("notifCounterDTO: $notifCounter");
          return ResponseWrapper(
              notifCounter, ResourceStatus.Success, "Login Berhasil");
        } else {
          print("notifCounterDTOError: ${dioResponse.data}");
          return ResponseWrapper(null, ResourceStatus.Error, null);
        }
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, null);
      }
    } catch (error) {
      print("error on NotifRepository: $error");
      throw Exception('An error occurred ' + error.toString());
    }
  }
}
