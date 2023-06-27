import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/bloc/iom/approval_state.dart';
import 'package:modernland_signflow/repos/iom/approval_repository.dart';

class IomDetailCubit extends Cubit<ApprovalState> {
  final ApprovalRepository repository;

  IomDetailCubit(this.repository) : super(ApprovalLoading());

  Future<void> fetchApprovals() async {
    try {
      final approvals = await repository.getApprovals();

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
