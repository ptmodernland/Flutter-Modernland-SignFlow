import 'package:bwa_cozy/bloc/pbj/dto/ListPBJDTO.dart';
import 'package:bwa_cozy/bloc/pbj/dto/list_komen_pbj.dart';

abstract class PBJState {}

//This will used to consider what success/failure state came from
enum PBJEStateActionType {
  LOAD_DETAIL,
  SHOW_HISTORY,
  SHOW_KOMENTAR,
  APPROVE,
  REJECT,
  RECOMMEND,
  DEFAULT,
}

class PBJStateInitial extends PBJState {}

class PBJStateLoading extends PBJState {
  final String progress;
  final PBJEStateActionType type;

  PBJStateLoading(
      {this.progress = "", this.type = PBJEStateActionType.DEFAULT});
}

class PBJStateLoadHistorySuccess extends PBJState {
  final List<ListPbjdto> datas;

  PBJStateLoadHistorySuccess({this.datas = const []});
}

class PBJStateLoadKomentarSuccess extends PBJState {
  final List<ListPBJCommentDTO> datas;

  PBJStateLoadKomentarSuccess({this.datas = const []});
}

class PBJStateSuccess extends PBJState {
  final String message;
  final PBJEStateActionType type;

  PBJStateSuccess(
      {this.message = "Selamat menggunakan aplikasi Modernland Approval",
      this.type = PBJEStateActionType.APPROVE});
}

class PBJStateFailure extends PBJState {
  final String message;
  final PBJEStateActionType type;

  PBJStateFailure({
    this.message = "",
    this.type = PBJEStateActionType.REJECT,
  });
}

class PBJStateSuccessListPBJ extends PBJState {
  final List<ListPbjdto> datas;

  PBJStateSuccessListPBJ({this.datas = const []});
}
