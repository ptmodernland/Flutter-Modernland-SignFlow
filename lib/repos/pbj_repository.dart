import 'package:dio/dio.dart';
import 'package:modernland_signflow/bloc/_wrapper/response_wrapper.dart';
import 'package:modernland_signflow/bloc/pbj/dto/ListPBJDTO.dart';
import 'package:modernland_signflow/bloc/pbj/dto/list_komen_pbj.dart';
import 'package:modernland_signflow/data/dio_client.dart';
import 'package:modernland_signflow/util/storage/sessionmanager/session_manager.dart';

class PBJRepository {
  DioClient dioClient;

  PBJRepository({required this.dioClient});

  Future<ResponseWrapper<String>> approvePBJ({
    String noPermintaan = "",
    String comment = "",
    String pin = "",
  }) async {
    var logTag = "Approve PBJ";
    try {
      print("trying $logTag");
      var userID = "";
      var usersession = await SessionManager.getUserFromSession();
      if (usersession != null) {
        userID = usersession.idUser;
      }
      // Prepare the request URL
      var url =
          'https://approval.modernland.co.id/androidiom/proses_approve_pbj.jsp?$userID';
      var data = FormData.fromMap({
        'no_permintaan': noPermintaan,
        'id_user': userID ?? '',
        'komenad': comment ?? null,
        'passwordUser': pin ?? '',
      });

      // Send the request using Dio
      var dioResponse = await dioClient.post(url, data: data);

      var jsonResponse = dioResponse.data;
      bool resStatus = jsonResponse['status'];
      var resMessage = jsonResponse['pesan'];
      print(jsonResponse.toString());

      if (dioResponse.statusCode == 200) {
        print("result $logTag 200");
        if (resStatus) {
          return ResponseWrapper(
              "Success", ResourceStatus.Success, "Berhasil Mengapprove PBJ");
        } else {
          return ResponseWrapper(resMessage, ResourceStatus.Error,
              "Gagal Approve PBJ : " + resMessage);
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

  Future<ResponseWrapper<String>> rejectPBJ({
    String noPermintaan = "",
    String comment = "",
    String pin = "",
  }) async {
    var logTag = "Reject PBJ";
    try {
      print("trying $logTag");
      var userID = "";
      var usersession = await SessionManager.getUserFromSession();
      if (usersession != null) {
        userID = usersession.idUser;
      }
      // Prepare the request URL
      var url = 'androidiom/proses_cancel_pbj.jsp?$userID';
      var data = FormData.fromMap({
        'no_permintaan': noPermintaan,
        'id_user': userID ?? '',
        'komenad': comment ?? null,
        'passwordUser': pin ?? '',
      });

      // Send the request using Dio
      var dioResponse = await dioClient.post(url, data: data);

      var jsonResponse = dioResponse.data;
      bool resStatus = jsonResponse['status'];
      var resMessage = jsonResponse['pesan'];
      print(jsonResponse.toString());

      if (dioResponse.statusCode == 200) {
        print("result $logTag 200");
        if (resStatus) {
          return ResponseWrapper(
              "Success", ResourceStatus.Success, "PBJ Berhasil Direject");
        } else {
          return ResponseWrapper(resMessage, ResourceStatus.Error,
              "Gagal Reject PBJ : " + resMessage);
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

  Future<ResponseWrapper<List<ListPbjdto>>> getHistoryPBJ({
    String? startDate = null,
    String? endDate = null,
    String? year = null,
    String? noPermintaan = null,
    bool isAll = true,
  }) async {
    try {
      var username = "";
      var usersession = await SessionManager.getUserFromSession();

      if (usersession != null) {
        username = usersession.username;
      }
      // Prepare the request URL
      var url = 'androidiom/list_pbj_new.php?username=$username';

      // Send the request using Dio
      var dioResponse = await dioClient.post(url);

      var jsonResponse = dioResponse.data;

      if (dioResponse.statusCode == 200) {
        print("168 result 200");
        print("json dataaa : $jsonResponse");
        final dataList = List<Map<String, dynamic>>.from(jsonResponse);
        final datas =
            dataList.map((data) => ListPbjdto.fromJson(data)).toList();
        print("168 success siii");
        return ResponseWrapper(datas, ResourceStatus.Success, "Success");
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
      }
    } catch (error, stackTrace) {
      print("Error on ApprovalMainPageRepository: " + error.toString());
      print(stackTrace.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  Future<ResponseWrapper<List<ListPBJCommentDTO>>> getKomentarPBJ(
      {String? noPermintaan = null}) async {
    var logTag = "Getting PBJ Komentar";
    try {
      print("trying getting PBJ Komentar $noPermintaan");
      // Prepare the request URL
      var url =
          'https://approval.modernland.co.id/androidiom/get_komen_pbj.php?no_permintaan=$noPermintaan';

      // Send the request using Dio
      var dioResponse = await dioClient.get(url);

      var jsonResponse = dioResponse.data;
      print(jsonResponse.toString());

      if (dioResponse.statusCode == 200) {
        print("result komentar 200");
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(jsonResponse);
        final List<ListPBJCommentDTO> datas =
            dataList.map((data) => ListPBJCommentDTO.fromJson(data)).toList();
        // Now you have the list of `Bottle` objects
        return ResponseWrapper(datas, ResourceStatus.Success, "Success");
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
      }
    } catch (error) {
      print("error on PBJRepository " + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }
}
