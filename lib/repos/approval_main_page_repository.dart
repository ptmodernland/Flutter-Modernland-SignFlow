import 'package:modernland_signflow/bloc/_wrapper/response_wrapper.dart';
import 'package:modernland_signflow/bloc/all_approval/dto/detail_pbj_dto.dart';
import 'package:modernland_signflow/bloc/all_approval/dto/list_all_compare_dto.dart';
import 'package:modernland_signflow/bloc/kasbon/dto/ListAllKasbonDTO.dart';
import 'package:modernland_signflow/bloc/pbj/dto/ListPBJDTO.dart';
import 'package:modernland_signflow/bloc/realisasi/dto/RealisasiListDTO.dart';
import 'package:modernland_signflow/data/dio_client.dart';
import 'package:modernland_signflow/util/storage/sessionmanager/session_manager.dart';

class ApprovalMainPageRepository {
  DioClient dioClient;

  ApprovalMainPageRepository({required this.dioClient});

  Future<ResponseWrapper<List<ListPbjdto>>> getPBJWaitingList() async {
    var logTag = "Getting PBJ";
    try {
      print("trying getting PBJ");
      var username = "";
      var usersession = await SessionManager.getUserFromSession();

      if (usersession != null) {
        username = usersession.username;
      }
      // Prepare the request
      var url = 'androidiom/list_approve_pbj.php?username=$username';

      print("URL PBJ");
      print("$logTag" + "SS");

      // Send the request
      var response = await dioClient.post(url);

      if (response.statusCode == 200) {
        print("result 200");
        final jsonData = response.data;
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(jsonData);
        final List<ListPbjdto> datas =
            dataList.map((data) => ListPbjdto.fromJson(data)).toList();

        return ResponseWrapper(datas, ResourceStatus.Success, "Success");
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
      }
    } catch (error) {
      print("error on ApprovalMainPageRepository: $error");
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  Future<ResponseWrapper<List<ListAllCompareDTO>>>
      getCompareWaitingList() async {
    var logTag = "Getting PBJ";
    try {
      print("trying getting PBJ");
      var username = "";
      var usersession = await SessionManager.getUserFromSession();

      if (usersession != null) {
        username = usersession.username;
      }
      // Prepare the request
      var url = 'androidiom/list_approve_compare.php?username=$username';

      print("URL PBJ");
      print("$logTag" + "SS");

      // Send the request
      var response = await dioClient.post(url);

      if (response.statusCode == 200) {
        print("result 200");
        final jsonData = response.data;
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(jsonData);
        final List<ListAllCompareDTO> datas =
            dataList.map((data) => ListAllCompareDTO.fromJson(data)).toList();

        return ResponseWrapper(datas, ResourceStatus.Success, "Success");
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
      }
    } catch (error) {
      print("error on ApprovalMainPageRepository: $error");
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  Future<ResponseWrapper<DetailPBJDTO>> getPBJDetail(
      String idPermintaan) async {
    var logTag = "Getting Detail PBJ";
    try {
      print("trying to get PBJ detail");
      // Prepare the request
      var url = 'androidiom/get_permohonan.php?nopermintaan=$idPermintaan';

      // Send the request
      var response = await dioClient.post(url);

      if (response.statusCode == 200) {
        print("result Detail PBJ 200");
        final jsonData = response.data;
        final DetailPBJDTO data = DetailPBJDTO.fromJson(jsonData);

        print("result PBJ detail success");
        return ResponseWrapper(data, ResourceStatus.Success, "Success");
      } else {
        print("result PBJ detail encountered an error");
        return ResponseWrapper(null, ResourceStatus.Error, "An error occurred");
      }
    } catch (error) {
      print("error on ApprovalMainPageRepository (PBJ detail): $error");
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  Future<ResponseWrapper<List<ListAllKasbonDto>>> getKasbonWaitingList() async {
    var logTag = "Getting Kasbon";
    try {
      print("trying getting Kasbon");
      var username = "";
      var usersession = await SessionManager.getUserFromSession();

      if (usersession != null) {
        username = usersession.username;
      }
      // Prepare the request
      var url = 'androidiom/list_approve_kasbon.php?username=$username';

      print("URL KASBON");
      print("$logTag" + "SS");

      // Send the request
      var response = await dioClient.post(url);

      if (response.statusCode == 200) {
        print("result Kasbon 200");
        final jsonData = response.data;
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(jsonData);
        final List<ListAllKasbonDto> datas =
            dataList.map((data) => ListAllKasbonDto.fromJson(data)).toList();

        print("result Kasbon Success");
        return ResponseWrapper(datas, ResourceStatus.Success, "Success");
      } else {
        print("result Kasbon Terjadi Kesalahan");
        return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
      }
    } catch (error) {
      print("error on ApprovalMainPageRepository (Kasbon): $error");
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  Future<ResponseWrapper<List<RealisasiListDto>>>
      getReailisasiWaitingList() async {
    var logTag = "Getting Realisasi";
    try {
      print("trying $logTag");
      var username = "";
      var usersession = await SessionManager.getUserFromSession();

      if (usersession != null) {
        username = usersession.username;
      }
      // Prepare the request
      var url = 'androidiom/list_approve_realisasi.php?username=$username';

      print("$logTag" + "SS");

      // Send the request
      var response = await dioClient.post(url);

      if (response.statusCode == 200) {
        print("result Kasbon 200");
        final jsonData = response.data;
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(jsonData);
        final datas =
            dataList.map((data) => RealisasiListDto.fromJson(data)).toList();

        print("result Kasbon Success");
        return ResponseWrapper(datas, ResourceStatus.Success, "Success");
      } else {
        print("result Kasbon Terjadi Kesalahan");
        return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
      }
    } catch (error) {
      print("error on ApprovalMainPageRepository (Realisasi): $error");
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }
}
