import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/bloc/kasbon/kasbon_action_event.dart';
import 'package:bwa_cozy/bloc/kasbon/kasbon_state.dart';
import 'package:bwa_cozy/repos/kasbon_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KasbonActionBloc extends Bloc<KasbonActionEvent, KasbonState> {
  final KasbonRepository repo;

  KasbonActionBloc(this.repo) : super(KasbonStateInitial()) {
    on<SendApprove>((event, emit) async {
      print("on bloc sendQRCompareApprove");
      emit(KasbonStateLoading());
      try {
        final request = await repo.approveKasbon(
          noPermintaan: event.noKasbon,
          comment: event.comment,
          pin: event.pin,
        );
        if (request.status == ResourceStatus.Success) {
          await Future.delayed(Duration(seconds: 1, milliseconds: 500));
          emit(KasbonStateSuccess(
              message: request.message.toString(),
              type: KasbonEActionType.APPROVE));
        } else {
          emit(KasbonStateFailure(
              message: request.message.toString(),
              type: KasbonEActionType.APPROVE));
        }
      } catch (e) {
        emit(KasbonStateFailure(message: e.toString()));
      }
    });
    //reject PBJ
    on<SendReject>((event, emit) async {
      emit(KasbonStateLoading());
      print("on bloc sendQRCompareReject");
      try {
        final request = await repo.rejectKasbon(
          noPermintaan: event.noKasbon,
          comment: event.comment,
          pin: event.pin,
        );
        if (request.status == ResourceStatus.Success) {
          await Future.delayed(Duration(seconds: 1, milliseconds: 500));
          emit(KasbonStateSuccess(
              message: request.message.toString(),
              type: KasbonEActionType.REJECT));
        } else {
          emit(KasbonStateFailure(
              message: request.message.toString(),
              type: KasbonEActionType.REJECT));
        }
      } catch (e) {
        emit(
          KasbonStateFailure(
              message: e.toString(), type: KasbonEActionType.REJECT),
        );
      }
    });
  }
}
