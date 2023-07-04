import 'package:modernland_signflow/bloc/_wrapper/response_wrapper.dart';
import 'package:modernland_signflow/data/dio_client.dart';
import 'package:modernland_signflow/repos/broadcast_message/dto/broadcast_message_response_dto.dart';

class BroadcastMessageRepository {
  final DioClient dioClient;

  BroadcastMessageRepository({required this.dioClient});

  Future<ResponseWrapper<BroadcastMessageResponseDto>>
      getBroadcastMessage() async {
    var logTag = 'Getting kasbon Komentar';
    try {
      var url = 'androidiom/flutter_broadcast_message.php';

      var dioResponse = await dioClient.get(url);

      var jsonResponse = dioResponse.data;
      print(jsonResponse.toString());

      if (dioResponse.statusCode == 200) {
        print('result $logTag 200');
        var jsonObj = BroadcastMessageResponseDto.fromJson(jsonResponse);
        print('$logTag success $jsonObj');
        return ResponseWrapper(jsonObj, ResourceStatus.Success, 'Success');
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, 'Terjadi Kesalahan');
      }
    } catch (error) {
      print('error on $logTag ' + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }
}
