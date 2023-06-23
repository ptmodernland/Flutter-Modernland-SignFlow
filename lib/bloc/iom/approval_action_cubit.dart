import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/bloc/iom/approval_state.dart';
import 'package:bwa_cozy/repos/iom/approval_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApprovalActionCubit extends Cubit<ApprovalState> {
  final ApprovalRepository repository;

  ApprovalActionCubit(this.repository) : super(ApprovalLoading());

  Future<void> approveIom(
      {required String noIom,
      required String idIom,
      String comment = '',
      required String pin}) async {
    try {
      emit(ApprovalLoading());
      await Future.delayed(Duration(seconds: 2));
      final approvals = await repository.approveIom(
        noIom: noIom,
        pin: pin,
        comment: comment,
        idIom: idIom,
      );

      if (approvals.status == ResourceStatus.Success) {
        emit(ApprovalStateApproveSuccess(approvals.message ?? ""));
      }
      if (approvals.status == ResourceStatus.Error) {
        emit(ApprovalStateRejectError(approvals.message ?? ""));
      }
    } catch (e) {
      emit(ApprovalError('Failed to approve IOM: $e'));
    }
  }

  Future<void> rejectIom(
      {required String noIom,
      required String idIom,
      String comment = '',
      required String pin}) async {
    try {
      emit(ApprovalLoading());
      await Future.delayed(Duration(seconds: 2));
      final approvals = await repository.rejectIom(
        noIom: noIom,
        pin: pin,
        comment: comment,
        idIom: idIom,
      );

      if (approvals.status == ResourceStatus.Success) {
        emit(ApprovalStateApproveSuccess(approvals.message ?? ""));
      }
      if (approvals.status == ResourceStatus.Error) {
        emit(ApprovalStateRejectError(approvals.message ?? ""));
      }
    } catch (e) {
      emit(ApprovalError('Failed to approve IOM: $e'));
    }
  }
}
