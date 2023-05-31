import 'dart:convert';

import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/bloc/all_approval/dto/detail_pbj_dto.dart';
import 'package:bwa_cozy/bloc/all_approval/dto/list_all_compare_dto.dart';
import 'package:bwa_cozy/bloc/all_approval/dto/list_all_pbj_kasbon_dto.dart';
import 'package:bwa_cozy/bloc/pbj/dto/ListPBJDTO.dart';
import 'package:bwa_cozy/util/storage/sessionmanager/session_manager.dart';
import 'package:http/http.dart' as http;

class ApprovalMainPageRepository {
  //use this to get all waiting PBJ
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
      var url = Uri.parse(
          'https://approval.modernland.co.id/androidiom/list_approve_pbj.php?username=' +
              username);
      // Set the form data
      print("URL PBJ");

      print("$logTag" + "SS");
      // Send the request
      var response = await http.post(url);
      // Get the response body as a string
      var responseBody = response.body;
      // print("$logTag : $responseBody");
      var jsonResponse = jsonDecode(responseBody);
      // Extract the code and message fields
      final result = jsonDecode(response.body);
      print(result.toString());
      if (response.statusCode == 200) {
        print("result 200");
        final jsonData = json.decode(response.body);
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(jsonData);
        final List<ListPbjdto> datas =
            dataList.map((data) => ListPbjdto.fromJson(data)).toList();
        // Now you have the list of `Bottle` objects
        return ResponseWrapper(datas, ResourceStatus.Success, "Success");
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
      }
    } catch (error) {
      print("error on ApprovalMainPageRepository " + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
    return ResponseWrapper(null, ResourceStatus.Success, "Login Berhasil");
  }

  //use this to get all waiting Comparison
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
      // Prepare the request/Volumes/D/SharedFolder/iom/androidiom/counter_all.php
      var url = Uri.parse(
          'https://approval.modernland.co.id/androidiom/list_approve_compare.php?username=' +
              username);
      // Set the form data
      print("URL PBJ");

      print("$logTag" + "SS");
      // Send the request
      var response = await http.post(url);
      // Get the response body as a string
      var responseBody = response.body;
      // print("$logTag : $responseBody");
      var jsonResponse = jsonDecode(responseBody);
      // Extract the code and message fields
      final result = jsonDecode(response.body);
      print(result.toString());
      if (response.statusCode == 200) {
        print("result 200");
        final jsonData = json.decode(response.body);
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(jsonData);
        final List<ListAllCompareDTO> datas =
            dataList.map((data) => ListAllCompareDTO.fromJson(data)).toList();
        // Now you have the list of `Bottle` objects
        return ResponseWrapper(datas, ResourceStatus.Success, "Success");
      } else {
        return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
      }
    } catch (error) {
      print("error on ApprovalMainPageRepository " + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
    return ResponseWrapper(null, ResourceStatus.Success, "Login Berhasil");
  }

  //use this to see PBJ Detail
  Future<ResponseWrapper<DetailPBJDTO>> getPBJDetail(
      String idPermintaan) async {
    var logTag = "Getting Detail PBJ";
    try {
      print("trying to get PBJ detail");
      // Prepare the request
      var url = Uri.parse(
          'https://approval.modernland.co.id/androidiom/get_permohonan.php?nopermintaan=' +
              idPermintaan);
      // Send the request
      var response = await http.post(url);
      // Get the response body as a string
      var responseBody = response.body;
      // print("$logTag : $responseBody");
      var jsonResponse = jsonDecode(responseBody);

      if (response.statusCode == 200) {
        print("result Detail PBJ 200");
        final DetailPBJDTO data = DetailPBJDTO.fromJson(jsonResponse);

        print("result PBJ detail success");
        return ResponseWrapper(data, ResourceStatus.Success, "Success");
      } else {
        print("result PBJ detail encountered an error");
        return ResponseWrapper(null, ResourceStatus.Error, "An error occurred");
      }
    } catch (error) {
      print("error on ApprovalMainPageRepository (PBJ detail): " +
          error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }

  //use this to get all Kasbon
  Future<ResponseWrapper<List<ListAllKasbonDTO>>> getKasbonWaitingList() async {
    var logTag = "Getting Kasbon";
    try {
      print("trying getting Kasbon");
      var username = "";
      var usersession = await SessionManager.getUserFromSession();

      if (usersession != null) {
        username = usersession.username;
      }
      // Prepare the request
      var url = Uri.parse(
          'https://approval.modernland.co.id/androidiom/list_approve_kasbon.php?username=' +
              username);
      // Set the form data
      print("URL KASBON");

      print("$logTag" + "SS");
      // Send the request
      var response = await http.post(url);
      // Get the response body as a string
      var responseBody = response.body;
      // print("$logTag : $responseBody");
      var jsonResponse = jsonDecode(responseBody);
      // Extract the code and message fields
      final result = jsonDecode(response.body);
      print(result.toString());
      if (response.statusCode == 200) {
        print("result Kasbon 200");
        final jsonData = json.decode(response.body);
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(jsonData);
        final List<ListAllKasbonDTO> datas =
            dataList.map((data) => ListAllKasbonDTO.fromJson(data)).toList();
        // Now you have the list of `Bottle` objects
        print("result Kasbon Success");
        return ResponseWrapper(datas, ResourceStatus.Success, "Success");
      } else {
        print("result Kasbon Terjadi Kesalahan");
        return ResponseWrapper(null, ResourceStatus.Error, "Terjadi Kesalahan");
      }
    } catch (error) {
      print("error on ApprovalMainPageRepository (Kasbon) " + error.toString());
      return ResponseWrapper(null, ResourceStatus.Error, error.toString());
    }
  }


}
