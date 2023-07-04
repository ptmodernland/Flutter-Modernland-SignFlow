import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/bloc/kasbon/kasbon_comment_event.dart';
import 'package:modernland_signflow/bloc/kasbon/kasbon_state.dart';
import 'package:modernland_signflow/repos/kasbon_repository.dart';

class KasbonCommentBloc extends Bloc<KasbonCommentEvent, KasbonState> {
  final KasbonRepository repo;

  KasbonCommentBloc(this.repo) : super(KasbonStateInitial()) {
    on<GetKomentarKasbon>((event, emit) async {
      emit(KasbonStateLoading());
      print("start bloc request");
      try {
        final request =
            await repo.getKomentarKasbon(noPermintaan: event.noKasbon);
        if (request.data != null) {
          emit(KasbonStateLoadCommentSuccess(datas: request.data!));
          print("success bloc approval_main_page");
        } else {
          emit(KasbonStateFailure(
              type: KasbonEActionType.SHOW_KOMENTAR,
              message: request.message ?? ""));
        }
      } catch (e) {
        print("error occured on approval_main_page_bloc" + e.toString());
        emit(KasbonStateFailure(
            message: e.toString(), type: KasbonEActionType.SHOW_KOMENTAR));
      }
    });
  }
}
