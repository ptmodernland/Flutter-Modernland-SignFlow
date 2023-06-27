import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/bloc/realisasi/realisasi_action_event.dart';
import 'package:bwa_cozy/bloc/realisasi/realisasi_state.dart';
import 'package:bwa_cozy/repos/realisasi_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RealisasiActionBloc extends Bloc<RealisasiActionEvent, RealisasiState> {
  final RealisasiRepository repo;

  RealisasiActionBloc(this.repo) : super(RealisasiStateInitial()) {
    on<SendQRealisasiApprove>((event, emit) async {
      print("on bloc sendQRRealisasiApprove");
      emit(RealisasiStateLoading());
      try {
        final request = await repo.approveRealisasi(
          noRealisasi: event.noRealisasi,
          idRealisasi: event.idRealisasi,
          noKasbon: event.noKasbon,
          comment: event.comment,
          pin: event.pin,
        );
        if (request.status == ResourceStatus.Success) {
          emit(RealisasiStateSuccess(
              message: request.message.toString(),
              type: RealisasiEActionType.APPROVE));
        } else {
          emit(RealisasiStateFailure(
              message: request.message.toString(),
              type: RealisasiEActionType.APPROVE));
        }
      } catch (e) {
        emit(RealisasiStateFailure(message: e.toString()));
      }
    });
    //reject PBJ
    on<SendQRealisasiReject>((event, emit) async {
      emit(RealisasiStateLoading());
      print("on bloc sendQRRealisasiReject");
      try {
        final request = await repo.rejectRealisasi(
          noRealisasi: event.noRealisasi,
          noKasbon: event.noKasbon,
          idRealisasi: event.idRealisasi,
          comment: event.comment,
          pin: event.pin,
        );
        if (request.status == ResourceStatus.Success) {
          emit(RealisasiStateSuccess(
              message: request.message.toString(),
              type: RealisasiEActionType.REJECT));
        } else {
          emit(RealisasiStateFailure(
              message: request.message.toString(),
              type: RealisasiEActionType.REJECT));
        }
      } catch (e) {
        emit(
          RealisasiStateFailure(
              message: e.toString(), type: RealisasiEActionType.REJECT),
        );
      }
    });
  }
}
