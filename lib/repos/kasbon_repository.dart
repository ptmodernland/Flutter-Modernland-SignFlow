import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/bloc/kasbon/dto/KasbonCommentDTO.dart';
import 'package:bwa_cozy/bloc/kasbon/dto/KasbonDetailDTO.dart';
import 'package:bwa_cozy/bloc/kasbon/dto/ListAllKasbonDTO.dart';
import 'package:bwa_cozy/data/dio_client.dart';
import 'package:bwa_cozy/util/storage/sessionmanager/session_manager.dart';
import 'package:dio/dio.dart';

class KasbonRepository {
  final DioClient dioClient;

  KasbonRepository({required this.dioClient});

  Future<ResponseWrapper<String>> approveKasbon({
    String noPermintaan = '',
    String comment = '',
    String pin = '',
  }) async {
    var logTag = 'Approve Kasbon';
    try {
      print('trying $logTag');
      var userID = '';
      var usersession = await SessionManager.getUserFromSession();
      if (usersession != null) {
        userID = usersession.idUser;
      }

      var url = 'androidiom/proses_approve_kasbon.jsp?$userID';

      var body = FormData.fromMap({
        'noKasbon': noPermintaan,
        'id_user': userID ?? '',
        'komen': comment ?? null,
        'passwordUser': pin ?? '',
        'isFromFlutter': true
      });

      var dioResponse = await dioClient.post(url, data: body);

      var jsonResponse = dioResponse.data;
      print(jsonResponse.toString());

      if (dioResponse.statusCode == 200) {
        print('result $logTag 200');
        bool resStatus = jsonResponse['status'];
        var resMessage = jsonResponse['pesan'];

        if (resStatus) {
          return ResponseWrapper(
              'Success', ResourceStatus.Success, 'Berhasil Mengapprove Kasbon');
        } else {
          return ResponseWrapper(resMessage, ResourceStatus.Error,
              'Gagal Approve Kasbon : ' + resMessage);
        }
      } else {
        print('result $logTag Terjadi Kesalahan');
        return ResponseWrapper(null, ResourceStatus.Error, 'Terjadi Kesalahan');
      }
    } catch (error) {
      print('error on $logTag ' + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  Future<ResponseWrapper<String>> rejectKasbon({
    String noPermintaan = '',
    String comment = '',
    String pin = '',
  }) async {
    var logTag = 'Reject Kasbon';
    try {
      print('trying $logTag');
      var userID = '';
      var usersession = await SessionManager.getUserFromSession();
      if (usersession != null) {
        userID = usersession.idUser;
      }

      var url = 'androidiom/proses_cancel_kasbon.jsp?$userID';

      var body = FormData.fromMap({
        'nomor': noPermintaan,
        'id_user': userID ?? '',
        'komen': comment ?? null,
        'passwordUser': pin ?? ''
      });

      var dioResponse = await dioClient.post(url, data: body);

      var jsonResponse = dioResponse.data;
      print(jsonResponse.toString());

      if (dioResponse.statusCode == 200) {
        print('result $logTag 200');
        bool resStatus = jsonResponse['status'];
        var resMessage = jsonResponse['pesan'];

        if (resStatus) {
          return ResponseWrapper(
              'Success', ResourceStatus.Success, 'Kasbon Berhasil Direject');
        } else {
          return ResponseWrapper(resMessage, ResourceStatus.Error,
              'Gagal Reject Kasbon : ' + resMessage);
        }
      } else {
        print('result $logTag Terjadi Kesalahan');
        return ResponseWrapper(null, ResourceStatus.Error, 'Terjadi Kesalahan');
      }
    } catch (error) {
      print('error on $logTag ' + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  Future<ResponseWrapper<List<ListAllKasbonDto>>> getHistoryKasbon({
    String? startDate,
    String? endDate,
    String? year,
    String? noPermintaan,
    bool isAll = true,
  }) async {
    var logTag = 'Getting Kasbon';
    try {
      print('trying getting Kasbon');
      var username = '';
      var usersession = await SessionManager.getUserFromSession();
      if (usersession != null) {
        username = usersession.username;
      }

      var url = 'androidiom/list_kasbon.php?username=$username';

      var dioResponse = await dioClient.post(url);

      var jsonResponse = dioResponse.data;
      print(jsonResponse.toString());

      if (dioResponse.statusCode == 200) {
        print('result 200');
        final jsonData = jsonResponse;
        final dataList = List<Map<String, dynamic>>.from(jsonData);
        final datas =
            dataList.map((data) => ListAllKasbonDto.fromJson(data)).toList();
        print('success');
        return ResponseWrapper(datas, ResourceStatus.Success, 'Success');
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, 'Terjadi Kesalahan');
      }
    } catch (error) {
      print('error on ApprovalMainPageRepository ' + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  Future<ResponseWrapper<List<KasbonCommentDto>>> getKomentarKasbon({
    String? noPermintaan,
  }) async {
    var logTag = 'Getting kasbon Komentar';
    try {
      print('trying getting $logTag $noPermintaan');

      var url = 'androidiom/get_komen_kasbon.php?no_kasbon=$noPermintaan';

      var dioResponse = await dioClient.get(url);

      var jsonResponse = dioResponse.data;
      print(jsonResponse.toString());

      if (dioResponse.statusCode == 200) {
        print('result $logTag 200');
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(jsonResponse);
        final List<KasbonCommentDto> datas =
            dataList.map((data) => KasbonCommentDto.fromJson(data)).toList();
        print('komentar $logTag success $jsonResponse');
        return ResponseWrapper(datas, ResourceStatus.Success, 'Success');
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, 'Terjadi Kesalahan');
      }
    } catch (error) {
      print('error on $logTag ' + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  Future<ResponseWrapper<KasbonDetailDto>> getKasbonDetail(
      String noKasbon) async {
    var logTag = 'Getting Detail Kasbon';
    try {
      print('trying to $logTag');

      var url = 'androidiom/get_kasbon.php?noKasbon=$noKasbon';

      var dioResponse = await dioClient.post(url);

      var jsonResponse = dioResponse.data;
      print('$logTag : $jsonResponse');

      if (dioResponse.statusCode == 200) {
        print('result $logTag 200');
        final data = KasbonDetailDto.fromJson(jsonResponse);
        print('result $logTag success');
        return ResponseWrapper(data, ResourceStatus.Success, 'Success');
      } else {
        print('result $logTag encountered an error');
        return ResponseWrapper(null, ResourceStatus.Error, 'An error occurred');
      }
    } catch (error) {
      print('error on $logTag: $error');
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }
}
