import 'package:modernland_signflow/bloc/kasbon/dto/KasbonCommentDTO.dart';
import 'package:modernland_signflow/bloc/kasbon/dto/KasbonDetailDTO.dart';
import 'package:modernland_signflow/bloc/kasbon/dto/ListAllKasbonDTO.dart';
import 'package:modernland_signflow/bloc/pbj/dto/ListPBJDTO.dart';

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
  final List<ListAllKasbonDto> datas;

  KasbonStateLoadHistorySuccess({this.datas = const []});
}

class KasbonStateLoadCommentSuccess extends KasbonState {
  final List<KasbonCommentDto> datas;

  KasbonStateLoadCommentSuccess({this.datas = const []});
}

class KasbonDetailSuccess extends KasbonState {
  final KasbonDetailDto data;

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
