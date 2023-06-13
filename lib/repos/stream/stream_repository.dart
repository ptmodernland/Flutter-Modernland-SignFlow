import 'dart:convert';

import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/repos/stream/stream_paging_dto.dart';
import 'package:http/http.dart' as http;

class StreamRepository {
  Future<ResponseWrapper<List<StreamData>>> getMDLNNews() async {
    var logTag = "Getting MDLN News";
    try {
      print("trying $logTag");
      var url =
          Uri.parse('https://snips-api.feylabs.my.id/api/mdln-focused/news');
      var response = await http.get(url);
      // Get the response body as a string
      var responseBody = response.body;
      print("$logTag : $responseBody");
      var jsonResponse = jsonDecode(responseBody);
      // Extract the code and message fields
      final result = jsonDecode(response.body);
      // print(result.toString());
      if (response.statusCode == 200) {
        print("result 200");
        final jsonData = json.decode(response.body);
        final streamList = jsonData['data']['stream'] as List<dynamic>;
        print("result 201");
        final datas =
            streamList.map((data) => StreamData.fromJson(data)).toList();
        // Now you have the list of `Bottle` objects
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
    return ResponseWrapper(null, ResourceStatus.Success, "Login Berhasil");
  }
}
