import 'package:modernland_signflow/bloc/pbj/dto/ListPBJDTO.dart';
import 'package:modernland_signflow/bloc/pbj/dto/list_komen_pbj.dart';
import 'package:modernland_signflow/bloc/realisasi/dto/RealisasiDetailDTO.dart';
import 'package:modernland_signflow/bloc/realisasi/dto/RealisasiListDTO.dart';

abstract class RealisasiState {}

//This will used to consider what success/failure state came from
enum RealisasiEActionType {
  LOAD_DETAIL,
  SHOW_HISTORY,
  SHOW_KOMENTAR,
  APPROVE,
  REJECT,
  RECOMMEND,
  DEFAULT,
}

class RealisasiStateInitial extends RealisasiState {}

class RealisasiStateLoading extends RealisasiState {
  final String progress;
  final RealisasiEActionType type;

  RealisasiStateLoading(
      {this.progress = "", this.type = RealisasiEActionType.DEFAULT});
}

class RealisasiStateLoadHistorySuccess extends RealisasiState {
  final List<RealisasiListDto> datas;

  RealisasiStateLoadHistorySuccess({this.datas = const []});
}

class RealisasiStateLoadCommentSuccess extends RealisasiState {
  final List<ListPBJCommentDTO> datas;

  RealisasiStateLoadCommentSuccess({this.datas = const []});
}

class RealisasiDetailSuccess extends RealisasiState {
  final RealisasiDetailDto data;

  RealisasiDetailSuccess({required this.data});
}

class RealisasiStateSuccess extends RealisasiState {
  final String message;
  final RealisasiEActionType type;

  RealisasiStateSuccess(
      {this.message = "Selamat menggunakan aplikasi Modernland Approval",
      this.type = RealisasiEActionType.APPROVE});
}

class RealisasiStateFailure extends RealisasiState {
  final String message;
  final RealisasiEActionType type;

  RealisasiStateFailure({
    this.message = "",
    this.type = RealisasiEActionType.REJECT,
  });
}

class PBJStateSuccessListPBJ extends RealisasiState {
  final List<ListPbjdto> datas;

  PBJStateSuccessListPBJ({this.datas = const []});
}
