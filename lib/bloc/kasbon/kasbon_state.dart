import 'package:bwa_cozy/bloc/all_approval/dto/list_all_compare_dto.dart';
import 'package:bwa_cozy/bloc/compare/dto/detail_compare_dto.dart';
import 'package:bwa_cozy/bloc/pbj/dto/ListPBJDTO.dart';
import 'package:bwa_cozy/bloc/pbj/dto/list_komen_pbj.dart';

abstract class KasbonState {}

enum KasbonEActionType {
  LOAD_DETAIL,
  SHOW_HISTORY,
  SHOW_KOMENTAR,
  APPROVE,
  REJECT,
  RECOMMEND,
  DEFAULT,
}

class KasbonStateInitial extends KasbonState {}

class KasbonStateLoading extends KasbonState {
  final String progress;
  final KasbonEActionType type;

  KasbonStateLoading(
      {this.progress = "", this.type = KasbonEActionType.DEFAULT});
}

class KasbonStateLoadHistorySuccess extends KasbonState {
  final List<ListAllCompareDTO> datas;

  KasbonStateLoadHistorySuccess({this.datas = const []});
}

class KasbonStateLoadCommentSuccess extends KasbonState {
  final List<ListPBJCommentDTO> datas;

  KasbonStateLoadCommentSuccess({this.datas = const []});
}

class KasbonDetailSuccess extends KasbonState {
  final DetailCompareDTO data;

  KasbonDetailSuccess({required this.data});
}

class KasbonStateSuccess extends KasbonState {
  final String message;
  final KasbonEActionType type;

  KasbonStateSuccess(
      {this.message = "Selamat menggunakan aplikasi Modernland Approval",
      this.type = KasbonEActionType.APPROVE});
}

class KasbonStateFailure extends KasbonState {
  final String message;
  final KasbonEActionType type;

  KasbonStateFailure({
    this.message = "",
    this.type = KasbonEActionType.REJECT,
  });
}

class PBJStateSuccessListPBJ extends KasbonState {
  final List<ListPbjdto> datas;

  PBJStateSuccessListPBJ({this.datas = const []});
}
