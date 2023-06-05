import 'package:bwa_cozy/bloc/realisasi/realisasi_event.dart';
import 'package:bwa_cozy/bloc/realisasi/realisasi_state.dart';
import 'package:bwa_cozy/repos/realisasi_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RealisasiDetailBloc extends Bloc<RealisasiEvent, RealisasiState> {
  final RealisasiRepository repo;

  RealisasiDetailBloc(this.repo) : super(RealisasiStateInitial()) {
    on<GetRealisasiDetailEvent>((event, emit) async {
      try {
        final request = await repo.getRealisasiDetail(event.idRealisasi);
        if (request.data != null) {
          emit(RealisasiDetailSuccess(data: request.data!));
          print("success bloc approval_detail_pbj");
        } else {
          emit(RealisasiStateFailure(
              message: request.message ?? "",
              type: RealisasiEActionType.LOAD_DETAIL));
        }
      } catch (e) {
        print("error occured on approval pbj detail bloc" + e.toString());
        emit(RealisasiStateFailure(
            message: e.toString() ?? "",
            type: RealisasiEActionType.LOAD_DETAIL));
      }
    });
  }
}
