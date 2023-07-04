import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/bloc/realisasi/realisasi_comment_event.dart';
import 'package:modernland_signflow/bloc/realisasi/realisasi_state.dart';
import 'package:modernland_signflow/repos/realisasi_repository.dart';

class RealisasiCommentBloc extends Bloc<RealisasiCommentEvent, RealisasiState> {
  final RealisasiRepository repo;

  RealisasiCommentBloc(this.repo) : super(RealisasiStateInitial()) {
    on<GetKomentarRealisasi>((event, emit) async {
      emit(RealisasiStateLoading());
      print("start bloc request");
      try {
        final request =
            await repo.getCommentRealisasi(noCompare: event.noRealisasi);
        if (request.data != null) {
          emit(RealisasiStateLoadCommentSuccess(datas: request.data!));
          print("success bloc approval_main_page");
        } else {
          emit(RealisasiStateFailure(
              type: RealisasiEActionType.SHOW_KOMENTAR,
              message: request.message ?? ""));
        }
      } catch (e) {
        print("error occured on approval_main_page_bloc" + e.toString());
        emit(RealisasiStateFailure(
            message: e.toString(), type: RealisasiEActionType.SHOW_KOMENTAR));
      }
    });
  }
}
