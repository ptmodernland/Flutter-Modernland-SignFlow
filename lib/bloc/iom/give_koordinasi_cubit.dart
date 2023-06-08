import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/bloc/iom/approval_state.dart';
import 'package:bwa_cozy/repos/rekomendasi/rekomendasi_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GiveKoordinasiCubit extends Cubit<ApprovalState> {
  final RekomendasiRepository repository;

  GiveKoordinasiCubit(this.repository) : super(ApprovalInitial());

  Future<void> giveRekomendasi(
      {required String noIom,
      required String idIom,
      String comment = '',
      required String headUsername,
      required String pin}) async {
    emit(ApprovalLoading());

    try {
      final approvals = await repository.giveKoordinasi(
          noIom: noIom,
          pin: pin,
          comment: comment,
          idIom: idIom,
          headUsername: headUsername);
      if (approvals.status == ResourceStatus.Success) {
        emit(ApprovalStateApproveSuccess(approvals.message ?? ""));
      }
      if (approvals.status == ResourceStatus.Error) {
        emit(ApprovalStateApproveError(approvals.message ?? ""));
      }
    } catch (e) {
      emit(ApprovalStateApproveError('Failed to give recommendation: $e'));
    }
  }
}
