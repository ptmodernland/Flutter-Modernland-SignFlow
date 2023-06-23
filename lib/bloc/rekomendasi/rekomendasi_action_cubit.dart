import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/bloc/rekomendasi/rekomendasi_state.dart';
import 'package:bwa_cozy/repos/rekomendasi/rekomendasi_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RekomendasiActionCubit extends Cubit<RekomendasiState> {
  final RekomendasiRepository repository;

  RekomendasiActionCubit(this.repository) : super(RekomendaStateInitial());

  Future<void> clickForLoading() async {
    emit(RekomendasiStateLoading());
    await Future.delayed(Duration(seconds: 5));
    emit(RekomendaStateInitial());
    emit(RekomendasiStateError("Hehehe"));
  }

  Future<void> approveKoordinasi(
      {required String noIom,
      required String idIom,
      required String idKoordinasi,
      String comment = '',
      required String pin}) async {
    try {
      emit(RekomendasiStateLoading());
      await Future.delayed(Duration(seconds: 5));
      final approvals = await repository.approveKoordinasi(
        noIom: noIom,
        pin: pin,
        comment: comment,
        idKoordinasi: idKoordinasi,
        idIom: idIom,
      );

      if (approvals.status == ResourceStatus.Success) {
        emit(RekomendasiStateSuccess(approvals.message ?? ""));
      }
      if (approvals.status == ResourceStatus.Error) {
        emit(RekomendasiStateError(approvals.message ?? ""));
      }
    } catch (e) {
      emit(RekomendasiStateError('Failed to approve IOM: $e'));
    }
  }

  Future<void> rejectKoordinasi(
      {required String noIom,
      required String idIom,
      required String idKoordinasi,
      String comment = '',
      required String pin}) async {
    try {
      emit(RekomendasiStateLoading());
      await Future.delayed(Duration(seconds: 5));
      final approvals = await repository.rejectKoordinasi(
        noIom: noIom,
        pin: pin,
        comment: comment,
        idKoordinasi: idKoordinasi,
        idIom: idIom,
      );

      if (approvals.status == ResourceStatus.Success) {
        emit(RekomendasiStateSuccess(approvals.message ?? ""));
      }
      if (approvals.status == ResourceStatus.Error) {
        emit(RekomendasiStateError(approvals.message ?? ""));
      }
    } catch (e) {
      emit(RekomendasiStateError('Failed to approve IOM: $e'));
    }
  }
}
