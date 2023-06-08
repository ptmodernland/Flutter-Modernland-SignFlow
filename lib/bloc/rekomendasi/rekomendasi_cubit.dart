import 'package:bwa_cozy/bloc/rekomendasi/rekomendasi_state.dart';
import 'package:bwa_cozy/repos/rekomendasi/rekomendasi_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RekomendasiCubit extends Cubit<RekomendasiState> {
  final RekomendasiRepository repository;

  RekomendasiCubit(this.repository) : super(RekomendasiLoading());

  Future<void> fetchWaiting() async {
    try {
      emit(RekomendasiLoading());
      final stopwatch = Stopwatch()
        ..start(); // Create a stopwatch to measure elapsed time

      final approvals = await repository.getWaitingKoordinasi();

      if (stopwatch.elapsed < Duration(seconds: 1)) {
        await Future.delayed(Duration(seconds: 1)); // Add a delay of 3 seconds
      }

      if (approvals.isEmpty) {
        emit(RekomendasiEmpty());
      } else {
        emit(RekomendasiLoadWaitingSuccess(approvals));
      }
    } catch (e) {
      emit(RekomendasiError('Failed to load approvals: $e'));
    }
  }

  Future<void> fetchHistory() async {
    try {
      emit(RekomendasiLoading());
      final stopwatch = Stopwatch()
        ..start(); // Create a stopwatch to measure elapsed time

      final approvals = await repository.getHistoryKoordinasi();

      if (stopwatch.elapsed < Duration(seconds: 1)) {
        await Future.delayed(Duration(seconds: 1)); // Add a delay of 3 seconds
      }

      if (approvals.isEmpty) {
        emit(RekomendasiEmpty());
      } else {
        emit(RekomendasiLoadWaitingSuccess(approvals));
      }
    } catch (e) {
      emit(RekomendasiError('Failed to load history koordinasi: $e'));
    }
  }
}
