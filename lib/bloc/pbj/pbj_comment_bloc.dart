import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/bloc/pbj/pbj_comment_event.dart';
import 'package:modernland_signflow/bloc/pbj/pbj_state.dart';
import 'package:modernland_signflow/repos/pbj_repository.dart';

class PBJCommentBloc extends Bloc<PBJCommentEvent, PBJState> {
  final PBJRepository repo;

  PBJCommentBloc(this.repo) : super(PBJStateInitial()) {
    on<GetKomentarPBJ>((event, emit) async {
      emit(PBJStateLoading());
      print("start bloc request");
      try {
        final request = await repo.getKomentarPBJ(
            noPermintaan: event.noPermintaan.toString());
        if (request.data != null) {
          emit(PBJStateLoadKomentarSuccess(datas: request.data!));
          print("success bloc approval_main_page");
        } else {
          emit(PBJStateFailure(
              type: PBJEStateActionType.SHOW_KOMENTAR,
              message: request.message ?? ""));
        }
      } catch (e) {
        print("error occured on approval_main_page_bloc" + e.toString());
        emit(PBJStateFailure(
            message: e.toString(), type: PBJEStateActionType.SHOW_KOMENTAR));
      }
    });
  }
}
