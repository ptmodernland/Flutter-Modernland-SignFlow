import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/repos/broadcast_message/broadcast_message_repository.dart';
import 'package:modernland_signflow/repos/broadcast_message/dto/broadcast_message_response_dto.dart';

class BroadcastMessageCubit extends Cubit<AnnouncementState> {
  final BroadcastMessageRepository _repository;

  BroadcastMessageCubit(this._repository) : super(AnnouncementState.initial());

  Future<void> fetchAnnouncement() async {
    emit(state.copyWith(isLoading: true, isError: false));

    try {
      final announcement = await _repository.getBroadcastMessage();
      emit(state.copyWith(announcement: announcement.data));
    } catch (e) {
      emit(state.copyWith(isError: true));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}

class AnnouncementState {
  final bool isLoading;
  final bool isError;
  final BroadcastMessageResponseDto announcement;

  AnnouncementState({
    required this.isLoading,
    required this.isError,
    required this.announcement,
  });

  AnnouncementState copyWith({
    bool? isLoading,
    bool? isError,
    BroadcastMessageResponseDto? announcement,
  }) {
    return AnnouncementState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      announcement: announcement ?? this.announcement,
    );
  }

  factory AnnouncementState.initial() {
    return AnnouncementState(
      isLoading: false,
      isError: false,
      announcement: BroadcastMessageResponseDto(),
    );
  }
}
