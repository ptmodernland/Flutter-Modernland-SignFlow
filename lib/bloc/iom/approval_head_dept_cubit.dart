import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/bloc/iom/approval_state.dart';
import 'package:modernland_signflow/repos/iom/approval_repository.dart';

class ApprovalHeadDeptCubit extends Cubit<ApprovalState> {
  final ApprovalRepository repository;

  ApprovalHeadDeptCubit(this.repository) : super(ApprovalLoading());

  Future<void> fetchDeptHead({String? query}) async {
    emit(ApprovalLoading());
    try {
      final approvals = await repository.getDeptHead(query: query);
      if (approvals.isEmpty) {
        emit(ApprovalEmpty());
      } else {
        emit(ApprovalDeptHeadSuccess(deptHeads: approvals));
      }
    } catch (e) {
      emit(ApprovalError('Failed to load approvals: $e'));
    }
  }
}
