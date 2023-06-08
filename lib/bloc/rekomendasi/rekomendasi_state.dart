import 'package:bwa_cozy/repos/rekomendasi/dto/rekomendasi_waiting_dto.dart';

class RekomendasiState {}

class RekomendasiLoading extends RekomendasiState {}

class RekomendasiInitial extends RekomendasiState {}

class RekomendasiEmpty extends RekomendasiState {}

class RekomendasiLoadWaitingSuccess extends RekomendasiState {
  final List<RekomendasiWaitingDto> approvals;

  RekomendasiLoadWaitingSuccess(this.approvals);
}

class RekomendasiError extends RekomendasiState {
  final String message;

  RekomendasiError(this.message);
}
