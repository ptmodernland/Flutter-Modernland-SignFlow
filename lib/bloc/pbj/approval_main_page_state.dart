import 'package:bwa_cozy/bloc/login/login_response.dart';
import 'package:bwa_cozy/bloc/pbj/dto/list_all_compare_dto.dart';
import 'package:bwa_cozy/bloc/pbj/dto/list_all_pbj_dto.dart';
import 'package:bwa_cozy/bloc/pbj/dto/list_all_pbj_kasbon_dto.dart';

abstract class ApprovalMainPageState {}

class ApprovalMainPageStateInitial extends ApprovalMainPageState {}

class ApprovalMainPageStateLoading extends ApprovalMainPageState {}

class AuthStateLoginSuccess extends ApprovalMainPageState {
  final UserDTO loginSuccessPayload;
  final String message;

  AuthStateLoginSuccess(
      {required this.loginSuccessPayload,
      this.message = "Selamat menggunakan aplikasi Modernland Approval"});
}

class ApprovalMainPageStateSuccessListPBJ extends ApprovalMainPageState {
  final List<ListAllPbjDTO> datas;

  ApprovalMainPageStateSuccessListPBJ({this.datas = const []});
}

class ApprovalMainPageStateSuccessListCompare extends ApprovalMainPageState {
  final List<ListAllCompareDTO> datas;

  ApprovalMainPageStateSuccessListCompare({this.datas = const []});
}

class ApprovalMainPageStateSuccessListKasbon extends ApprovalMainPageState {
  final List<ListAllKasbonDTO> datas;

  ApprovalMainPageStateSuccessListKasbon({this.datas = const []});
}

class ApprovalMainPageStateFailure extends ApprovalMainPageState {
  final String error;

  ApprovalMainPageStateFailure({required this.error});
}
