import 'package:bwa_cozy/bloc/iom/approval_state.dart';
import 'package:bwa_cozy/repos/iom/approval_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApprovalCubit extends Cubit<ApprovalState> {
  final ApprovalRepository repository;

  ApprovalCubit(this.repository) : super(ApprovalLoading());

  Future<void> fetchApprovals() async {
    try {
      emit(ApprovalLoading());
      final stopwatch = Stopwatch()
        ..start(); // Create a stopwatch to measure elapsed time

      final approvals = await repository.getApprovals();

      if (stopwatch.elapsed < Duration(seconds: 1)) {
        await Future.delayed(Duration(seconds: 1)); // Add a delay of 3 seconds
      }

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
