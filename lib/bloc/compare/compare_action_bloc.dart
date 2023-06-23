import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/bloc/compare/compare_action_event.dart';
import 'package:bwa_cozy/bloc/compare/compare_state.dart';
import 'package:bwa_cozy/repos/compare_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompareActionBloc extends Bloc<CompareActionEvent, CompareState> {
  final CompareRepository repo;

  CompareActionBloc(this.repo) : super(CompareStateInitial()) {
    on<SendQCompareApprove>((event, emit) async {
      print("on bloc sendQRCompareApprove");
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

    //reject PBJ
    on<SendQCompareReject>((event, emit) async {
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
