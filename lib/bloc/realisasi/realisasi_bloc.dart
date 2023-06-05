import 'package:bwa_cozy/bloc/realisasi/realisasi_event.dart';
import 'package:bwa_cozy/bloc/realisasi/realisasi_state.dart';
import 'package:bwa_cozy/repos/realisasi_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RealisasiBloc extends Bloc<RealisasiEvent, RealisasiState> {
  final RealisasiRepository repo;

  RealisasiBloc(this.repo) : super(RealisasiStateInitial()) {
    on<GetHistoryRealisasi>((event, emit) async {
      emit(RealisasiStateLoading());
      print("start bloc request");
      try {
        final request = await repo.getHistoryRealisasi();
        if (request.data != null) {
          emit(RealisasiStateLoadHistorySuccess(datas: request.data!));
          print("success bloc approval_main_page");
        } else {
          emit(RealisasiStateFailure(
              type: RealisasiEActionType.SHOW_HISTORY,
              message: request.message ?? ""));
        }
      } catch (e) {
        print("error occured on approval_main_page_bloc" + e.toString());
        emit(RealisasiStateFailure(
            message: e.toString(), type: RealisasiEActionType.SHOW_HISTORY));
      }
    });
  }
}
