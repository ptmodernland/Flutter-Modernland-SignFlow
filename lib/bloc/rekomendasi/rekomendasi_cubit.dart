import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/bloc/rekomendasi/rekomendasi_state.dart';
import 'package:modernland_signflow/repos/rekomendasi/rekomendasi_repository.dart';

class RekomendasiCubit extends Cubit<RekomendasiState> {
  final RekomendasiRepository repository;

  RekomendasiCubit(this.repository) : super(RekomendasiStateLoading());

  Future<void> fetchWaiting() async {
    try {
      emit(RekomendasiStateLoading());
      final stopwatch = Stopwatch()
        ..start(); // Create a stopwatch to measure elapsed time

      final approvals = await repository.getWaitingKoordinasi();

      if (stopwatch.elapsed < Duration(seconds: 1)) {
        await Future.delayed(Duration(seconds: 1)); // Add a delay of 3 seconds
      }

      if (approvals.isEmpty) {
        emit(RekomendasiStateEmpty());
      } else {
        emit(RekomendasiLoadWaitingSuccess(approvals));
      }
    } catch (e) {
      emit(RekomendasiStateError('Failed to load approvals: $e'));
    }
  }

  Future<void> fetchHistory() async {
    try {
      emit(RekomendasiStateLoading());
      final stopwatch = Stopwatch()
        ..start(); // Create a stopwatch to measure elapsed time

      final approvals = await repository.getHistoryKoordinasi();

      if (stopwatch.elapsed < Duration(seconds: 1)) {
        await Future.delayed(Duration(seconds: 1)); // Add a delay of 3 seconds
      }

      if (approvals.isEmpty) {
        emit(RekomendasiStateEmpty());
      } else {
        emit(RekomendasiLoadWaitingSuccess(approvals));
      }
    } catch (e) {
      emit(RekomendasiStateError('Failed to load history koordinasi: $e'));
    }
  }
}
