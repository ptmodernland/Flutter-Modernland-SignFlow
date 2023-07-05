import 'package:modernland_signflow/bloc/_wrapper/response_wrapper.dart';
import 'package:modernland_signflow/data/dio_client.dart';
import 'package:modernland_signflow/repos/stream/Orderbook_dto.dart';
import 'package:modernland_signflow/repos/stream/shareholder_transaction_dto.dart';
import 'package:modernland_signflow/repos/stream/stream_paging_dto.dart';

class StreamRepository {
  final DioClient dioClient;

  StreamRepository({required this.dioClient});

  Future<ResponseWrapper<List<StreamData>>> getMDLNNews() async {
    var logTag = "Getting MDLN News";
    try {
      print("trying $logTag");
      var url = 'androidiom/snips/news.json';
      var dioResponse = await dioClient.get(url);
      var responseBody = dioResponse.data;
      print("$logTag : $responseBody");
      if (dioResponse.statusCode == 200) {
        print("result 200");
        final jsonData = responseBody;
        final streamList = jsonData['data']['stream'] as List<dynamic>;
        print("result 201");
        final datas =
            streamList.map((data) => StreamData.fromJson(data)).toList();
        print("success 199 " + datas.toString());
        print("result 202");
        return ResponseWrapper(datas, ResourceStatus.Success, "Success");
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
      }
    } catch (error) {
      print("error on MDLN Repository " + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  Future<ResponseWrapper<List<ShareholderMovementDTO>>>
      getShareholderTransaction() async {
    var logTag = "Getting Shareholder Transaction";
    try {
      print("trying $logTag");
      var url = 'androidiom/snips/shareholder-transaction.json';
      var dioResponse = await dioClient.get(url);
      var responseBody = dioResponse.data;
      print("$logTag : $responseBody");
      if (dioResponse.statusCode == 200) {
        print("result 200");
        final jsonData = responseBody;
        final streamList = jsonData['data']['movement'] as List<dynamic>;
        print("result 201");
        final datas = streamList
            .map((data) => ShareholderMovementDTO.fromJson(data))
            .toList();
        print("success 199 " + datas.toString());
        print("result 202");
        return ResponseWrapper(datas, ResourceStatus.Success, "Success");
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
      }
    } catch (error) {
      print("error on MDLN Repository " + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  Future<ResponseWrapper<OrderbookDto>> getMDLNPrice() async {
    var url = 'androidiom/snips/price.json';
    try {
      var dioResponse = await dioClient.get(url);
      var responseBody = dioResponse.data;
      if (dioResponse.statusCode == 200) {
        var jsonData = responseBody;
        final data = OrderbookDto.fromJson(jsonData);
        return ResponseWrapper(data, ResourceStatus.Success, "OK");
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, "Error");
      }
    } catch (error) {
      print("mdln price error: " + error.toString());
      return ResponseWrapper(
          null, ResourceStatus.Error, "Error: " + error.toString());
    }
  }
}
