import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/bloc/all_approval/dto/list_all_compare_dto.dart';
import 'package:bwa_cozy/bloc/compare/dto/detail_compare_dto.dart';
import 'package:bwa_cozy/bloc/pbj/dto/list_komen_pbj.dart';
import 'package:bwa_cozy/data/dio_client.dart';
import 'package:bwa_cozy/util/storage/sessionmanager/session_manager.dart';
import 'package:dio/dio.dart';

class CompareRepository {
  DioClient dioClient;

  CompareRepository({required this.dioClient});

  //use this to approve
  Future<ResponseWrapper<String>> approveCompare({
    String noPermintaan = "",
    String comment = "",
    String pin = "",
  }) async {
    var logTag = "Approve Compare";
    try {
      print("trying $logTag");
      var userID = "";
      var usersession = await SessionManager.getUserFromSession();
      if (usersession != null) {
        userID = usersession.idUser;
      }
      // Prepare the request
      var url = 'androidiom/proses_approve_compare.jsp?$userID';

      var formData = FormData.fromMap({
        'nomor': noPermintaan,
        'id_user': userID ?? '',
        'komen': comment ?? null,
        'passwordUser': pin ?? '',
      });

      // Set the form data
      print("$logTag" + "SS");
      var response = await dioClient.post(url, data: formData);
      var responseBody = response.data;
      bool resStatus = responseBody['status'];
      var resMessage = responseBody['pesan'];
      final result = (response.data);
      print(result.toString());
      if (response.statusCode == 200) {
        print("result $logTag 200");
        if (resStatus) {
          return ResponseWrapper(
            "Success",
            ResourceStatus.Success,
            "Berhasil Mengapprove Comparison",
          );
        } else {
          return ResponseWrapper(
            resMessage,
            ResourceStatus.Error,
            "Gagal Approve Comparison : " + resMessage,
          );
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

  //use this to REJECT
  Future<ResponseWrapper<String>> rejectCompare({
    String noPermintaan = "",
    String comment = "",
    String pin = "",
  }) async {
    var logTag = "Reject Compare";
    try {
      print("trying $logTag");
      var userID = "";
      var usersession = await SessionManager.getUserFromSession();
      if (usersession != null) {
        userID = usersession.idUser;
      }
      // Prepare the request
      var url = 'androidiom/proses_cancel_compare.jsp?$userID';

      var body = FormData.fromMap({
        'nomor': noPermintaan,
        'id_user': userID ?? '',
        'komen': comment ?? null,
        'passwordUser': pin ?? '',
        'isFromFlutter': true
      });

      // Set the form data
      print("$logTag" + "SS");
      var response = await dioClient.post(url, data: body);

      var responseBody = response.data;
      bool resStatus = responseBody['status'];
      var resMessage = responseBody['pesan'];

      if (response.statusCode == 200) {
        print("result $logTag 200");
        if (resStatus) {
          return ResponseWrapper(
            "Success",
            ResourceStatus.Success,
            "Compare Berhasil Direject",
          );
        } else {
          return ResponseWrapper(
            resMessage,
            ResourceStatus.Error,
            "Gagal Reject Compare : " + resMessage,
          );
        }
      } else {
        print("result $logTag Terjadi Kesalahan");
        return ResponseWrapper(null, ResourceStatus.Error, resMessage);
      }
    } catch (error, stackTrace) {
      print("error on $logTag " + error.toString());
      print(stackTrace);
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  Future<ResponseWrapper<List<ListAllCompareDTO>>> getHistoryCompare({
    String? startDate,
    String? endDate,
    String? year,
    String? noPermintaan,
    bool isAll = true,
  }) async {
    var logTag = "Getting Compare";
    try {
      print("trying getting Compare");
      var username = "";
      var usersession = await SessionManager.getUserFromSession();

      if (usersession != null) {
        username = usersession.username;
      }
      // Prepare the request
      var url =
          'androidiom/list_compare_new.php?username=$username&daritanggal=${startDate ?? ""}&sampaitanggal=${endDate ?? ""}&no_compare=${noPermintaan ?? ""}';

      // Send the request
      var response = await dioClient.post(url);

      // Get the response body as a string
      var responseBody = response.data;

      if (response.statusCode == 200) {
        print("result 200");
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(responseBody);
        final List<ListAllCompareDTO> datas =
            dataList.map((data) => ListAllCompareDTO.fromJson(data)).toList();
        // Now you have the list of `Bottle` objects
        return ResponseWrapper(datas, ResourceStatus.Success, "Success");
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
      }
    } catch (error) {
      print("error on CompareRepository " + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  Future<ResponseWrapper<List<ListPBJCommentDTO>>> getCommentCompare({
    String? noCompare,
  }) async {
    var logTag = "Getting Compare Comment";
    try {
      print("trying getting $logTag");
      // Prepare the request
      var url =
          'androidiom/get_komen_compare.php?no_compare=${noCompare.toString()}';

      // Send the request
      var response = await dioClient.get(url);

      // Get the response body as a string
      var responseBody = response.data;

      if (response.statusCode == 200) {
        print("result 200");
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(responseBody);
        final List<ListPBJCommentDTO> datas =
            dataList.map((data) => ListPBJCommentDTO.fromJson(data)).toList();
        // Now you have the list of `ListPBJCommentDTO` objects
        return ResponseWrapper(datas, ResourceStatus.Success, "Success");
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
      }
    } catch (error) {
      print("error on $logTag " + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  Future<ResponseWrapper<DetailCompareDTO>> getCompareDetail(
      String idPermintaan) async {
    var logTag = "Getting Detail Compare";
    try {
      print("trying to get Compare detail");
      // Prepare the request
      var url =
          Uri.parse('androidiom/get_compare.php?idcompare=' + idPermintaan);
      // Send the request
      var response = await dioClient.post(url.toString());

      // Get the response body as a string
      var responseBody = response.data;

      if (response.statusCode == 200) {
        print("result $logTag 200");
        final DetailCompareDTO data = DetailCompareDTO.fromJson(responseBody);

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