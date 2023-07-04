import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/bloc/_wrapper/response_wrapper.dart';
import 'package:modernland_signflow/bloc/compare/compare_action_event.dart';
import 'package:modernland_signflow/bloc/compare/compare_state.dart';
import 'package:modernland_signflow/repos/compare_repository.dart';

class CompareActionBloc extends Bloc<CompareActionEvent, CompareState> {
  final CompareRepository repo;

  CompareActionBloc(this.repo) : super(CompareStateInitial()) {
    on<SendQCompareApprove>((event, emit) async {
      emit(CompareStateLoading());
      try {
        final request = await repo.approveCompare(
          noPermintaan: event.noPermintaan,
          comment: event.comment,
          pin: event.pin,
        );
        if (request.status == ResourceStatus.Success) {
          emit(CompareStateSuccess(
              message: request.message.toString(),
              type: CompareEActionType.APPROVE));
        } else {
          emit(CompareStateFailure(
              message: request.message.toString(),
              type: CompareEActionType.APPROVE));
        }
      } catch (e) {
        emit(CompareStateFailure(message: e.toString()));
      }
    });

    //reject
    on<SendQCompareReject>((event, emit) async {
      emit(CompareStateLoading());
      print("on bloc sendQRCompareReject");
      try {
        final request = await repo.rejectCompare(
          noPermintaan: event.nomorCompare,
          comment: event.comment,
          pin: event.pin,
        );
        if (request.status == ResourceStatus.Success) {
          emit(CompareStateSuccess(
              message: request.message.toString(),
              type: CompareEActionType.REJECT));
        } else {
          emit(CompareStateFailure(
              message: request.message.toString(),
              type: CompareEActionType.REJECT));
        }
      } catch (e) {
        emit(
          CompareStateFailure(
              message: e.toString(), type: CompareEActionType.REJECT),
        );
      }
    });
  }
}
