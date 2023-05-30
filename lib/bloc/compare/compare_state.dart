import 'package:bwa_cozy/bloc/all_approval/dto/list_all_compare_dto.dart';
import 'package:bwa_cozy/bloc/all_approval/dto/list_all_pbj_dto.dart';
import 'package:bwa_cozy/bloc/compare/dto/detail_compare_dto.dart';
import 'package:bwa_cozy/bloc/pbj/dto/list_komen_pbj.dart';

abstract class CompareState {}

//This will used to consider what success/failure state came from
enum CompareEActionType {
  LOAD_DETAIL,
  SHOW_HISTORY,
  SHOW_KOMENTAR,
  APPROVE,
  REJECT,
  RECOMMEND,
  DEFAULT,
}

class CompareStateInitial extends CompareState {}

class CompareStateLoading extends CompareState {
  final String progress;
  final CompareEActionType type;

  CompareStateLoading({this.progress = "", this.type = CompareEActionType.DEFAULT});
}

class CompareStateLoadHistorySuccess extends CompareState {
  final List<ListAllCompareDTO> datas;

  CompareStateLoadHistorySuccess({this.datas = const []});
}

class CompareStateLoadCommentSuccess extends CompareState {
  final List<ListPBJCommentDTO> datas;

  CompareStateLoadCommentSuccess({this.datas = const []});
}

class CompareDetailSuccess extends CompareState {
  final DetailCompareDTO data;

  CompareDetailSuccess({required this.data});
}

class CompareStateSuccess extends CompareState {
  final String message;
  final CompareEActionType type;

  CompareStateSuccess({this.message = "Selamat menggunakan aplikasi Modernland Approval",
    this.type = CompareEActionType.APPROVE});
}

class CompareStateFailure extends CompareState {
  final String message;
  final CompareEActionType type;

  CompareStateFailure({
    this.message = "",
    this.type = CompareEActionType.REJECT,
  });
}

class PBJStateSuccessListPBJ extends CompareState {
  final List<ListAllPbjDTO> datas;

  PBJStateSuccessListPBJ({this.datas = const []});
}
