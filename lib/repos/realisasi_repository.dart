import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/bloc/pbj/dto/list_komen_pbj.dart';
import 'package:bwa_cozy/bloc/realisasi/dto/RealisasiDetailDTO.dart';
import 'package:bwa_cozy/bloc/realisasi/dto/RealisasiListDTO.dart';
import 'package:bwa_cozy/data/dio_client.dart';
import 'package:bwa_cozy/util/storage/sessionmanager/session_manager.dart';

class RealisasiRepository {
  final DioClient dioClient;

  RealisasiRepository({required this.dioClient});

  Future<ResponseWrapper<String>> approveRealisasi({
    String idRealisasi = "",
    String noKasbon = "",
    String noRealisasi = "",
    String comment = "",
    String pin = "",
  }) async {
    var logTag = "Approve Realisasi";
    try {
      print("trying $logTag");
      var userID = "";
      var usersession = await SessionManager.getUserFromSession();
      if (usersession != null) {
        userID = usersession.idUser;
      }

      var url = 'androidiom/proses_approve_realisasi.jsp?' + userID;

      var body = {
        'noRealisasi': noRealisasi,
        'idRealisasi': idRealisasi,
        'noKasbon': noKasbon,
        'id_user': userID ?? '',
        'komen': comment ?? null,
        'passwordUser': pin ?? '',
      };

      print("$logTag SS");
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

  // Use this to REJECT
  Future<ResponseWrapper<String>> rejectRealisasi({
    String noRealisasi = "",
    String comment = "",
    String pin = "",
    String idRealisasi = "",
    String noKasbon = "",
  }) async {
    var logTag = "Reject Realisasi";
    try {
      print("trying $logTag");
      var userID = "";
      var usersession = await SessionManager.getUserFromSession();
      if (usersession != null) {
        userID = usersession.idUser;
      }

      var url = 'androidiom/proses_cancel_realisasi.jsp?' + userID;

      var body = {
        'noRealisasi': noRealisasi,
        'idRealisasi': idRealisasi,
        'noKasbon': noKasbon,
        'id_user': userID ?? '',
        'komen': comment ?? null,
        'passwordUser': pin ?? '',
      };

      print("$logTag SS");
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
    } catch (error) {
      print("error on $logTag " + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  Future<ResponseWrapper<List<RealisasiListDto>>> getHistoryRealisasi({
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

      var url = 'androidiom/list_realisasi.php?username=' + username;

      print("URL History PBJ");
      var response = await dioClient.post(url);
      var responseBody = response.data;

      if (response.statusCode == 200) {
        print("result 200");
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(responseBody);
        final datas =
            dataList.map((data) => RealisasiListDto.fromJson(data)).toList();

        return ResponseWrapper(datas, ResourceStatus.Success, "Success");
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
      }
    } catch (error) {
      print("error on CompareRepository " + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }

    return ResponseWrapper(null, ResourceStatus.Success, "Login Berhasil");
  }

  Future<ResponseWrapper<List<ListPBJCommentDTO>>> getCommentRealisasi({
    String? noCompare,
  }) async {
    var logTag = "Getting Realisasi Comment";
    try {
      print("trying getting $logTag");

      var url = 'androidiom/get_komen_realisasi.php?no=' + noCompare.toString();

      var response = await dioClient.get(url);
      var responseBody = response.data;

      if (response.statusCode == 200) {
        print("result 200");
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(responseBody);
        final List<ListPBJCommentDTO> datas =
            dataList.map((data) => ListPBJCommentDTO.fromJson(data)).toList();

        return ResponseWrapper(datas, ResourceStatus.Success, "Success");
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
      }
    } catch (error) {
      print("error on $logTag " + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  Future<ResponseWrapper<RealisasiDetailDto>> getRealisasiDetail(
      String idPermintaan) async {
    var logTag = "Getting Detail Compare";
    try {
      print("trying to get Compare detail");

      var url = 'androidiom/get_realisasi.php?noRealisasi=' + idPermintaan;

      var response = await dioClient.post(url);
      var responseBody = response.data;
      print("$logTag : $responseBody");

      if (response.statusCode == 200) {
        print("result $logTag 200");
        final data = RealisasiDetailDto.fromJson(responseBody);

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
