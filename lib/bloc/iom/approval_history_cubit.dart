import 'package:bwa_cozy/bloc/iom/approval_state.dart';
import 'package:bwa_cozy/repos/iom/approval_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApprovalHistoryCubit extends Cubit<ApprovalState> {
  final ApprovalRepository repository;

  ApprovalHistoryCubit(this.repository) : super(ApprovalLoading());

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
}
