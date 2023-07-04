import 'package:modernland_signflow/bloc/iom/approval_state.dart';
import 'package:modernland_signflow/repos/iom/approval_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApprovalByCategoryCubit extends Cubit<ApprovalState> {
  final ApprovalRepository repository;

  ApprovalByCategoryCubit(this.repository) : super(ApprovalLoading());

  Future<void> fetchApprovalByCategory(String categoryId) async {
    try {
      emit(ApprovalLoading());
      final approvals = await repository.getByCategory(categoryId);
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
