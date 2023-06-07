import 'package:bwa_cozy/bloc/iom/approval_state.dart';
import 'package:bwa_cozy/repos/iom/approval_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApprovalLogCubit extends Cubit<ApprovalState> {
  final ApprovalRepository repository;

  ApprovalLogCubit(this.repository) : super(ApprovalLoading());

  Future<void> fetchLog(String noIom) async {
    try {
      final approvals = await repository.getMemoLog(noIom);

      if (approvals.isEmpty) {
        emit(ApprovalEmpty());
      } else {
        emit(ApprovalLogSuccess(logs: approvals));
      }
    } catch (e) {
      emit(ApprovalError('Failed to load approvals: $e'));
    }
  }
}
