import 'package:bwa_cozy/bloc/stream/stream_state.dart';
import 'package:bwa_cozy/repos/stream/stream_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StreamCubit extends Cubit<StreamState> {
  final StreamRepository repository;

  StreamCubit(this.repository) : super(StreamStateInitial());

  Future<void> fetchStream() async {
    try {
      emit(StreamStateLoading());
      final stopwatch = Stopwatch()
        ..start(); // Create a stopwatch to measure elapsed time

      final approvals = await repository.getMDLNNews();

      if (stopwatch.elapsed < Duration(seconds: 1)) {
        await Future.delayed(Duration(seconds: 1)); // Add a delay of 3 seconds
      }

      if (approvals.data != null) {
        emit(StreamStateLoadSuccess(datas: approvals.data!));
      }
    } catch (e) {
      emit(StreamStateFailure(message: 'Failed to load approvals: $e'));
    }
  }
}
