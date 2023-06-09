import 'package:bwa_cozy/repos/rekomendasi/dto/rekomendasi_waiting_dto.dart';

class RekomendasiState {}

class RekomendasiStateLoading extends RekomendasiState {}

class RekomendaStateInitial extends RekomendasiState {}

class RekomendasiStateEmpty extends RekomendasiState {}

class RekomendasiLoadWaitingSuccess extends RekomendasiState {
  final List<RekomendasiWaitingDto> approvals;

  RekomendasiLoadWaitingSuccess(this.approvals);
}

class RekomendasiStateSuccess extends RekomendasiState {
  final String message;

  RekomendasiStateSuccess(this.message);
}

class RekomendasiStateError extends RekomendasiState {
  final String message;

  RekomendasiStateError(this.message);
}