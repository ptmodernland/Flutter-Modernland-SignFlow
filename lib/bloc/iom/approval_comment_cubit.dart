import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/bloc/iom/approval_state.dart';
import 'package:modernland_signflow/repos/iom/approval_repository.dart';

class ApprovalCommentCubit extends Cubit<ApprovalState> {
  final ApprovalRepository repository;

  ApprovalCommentCubit(this.repository) : super(ApprovalLoading());

  Future<void> fetchApprovaHistory() async {
    try {
      final approvals = await repository.getHistory();
      if (approvals.isEmpty) {
        emit(ApprovalEmpty());
      } else {
        emit(ApprovalSuccess(approvals));
      }
    } catch (e) {
      emit(ApprovalError('Failed to load approvals: $e'));
    }
  }

  Future<void> fetchApprovalComment(String noIom) async {
    try {
      final approvals = await repository.getIOMComment(noIom);
      if (approvals.isEmpty) {
        emit(ApprovalEmpty());
      } else {
        emit(ApprovalCommentSuccess(comments: approvals));
      }
    } catch (e) {
      emit(ApprovalCommentError('Failed to load comments: $e'));
    }
  }
}
