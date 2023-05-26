import 'package:bwa_cozy/bloc/_wrapper/response_wrapper.dart';
import 'package:bwa_cozy/bloc/pbj/pbj_event.dart';
import 'package:bwa_cozy/bloc/pbj/pbj_state.dart';
import 'package:bwa_cozy/repos/pbj_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PBJBloc extends Bloc<PBJEvent, PBJState> {
  final PBJRepository repo;

  PBJBloc(this.repo) : super(PBJStateInitial()) {
    //approve PBJ
    on<SendQPBJApprove>((event, emit) async {
      print("on bloc sendQRPBJApprove");
      try {
        final request = await repo.approvePBJ(
          noPermintaan: event.noPermintaan,
          comment: event.comment,
          pin: event.pin,
        );
        if (request.status == ResourceStatus.Success) {
          emit(PBJStateSuccess(
              message: request.message.toString(),
              type: PBJEStateActionType.APPROVE));
        } else {
          emit(PBJStateFailure(
              message: request.message.toString(),
              type: PBJEStateActionType.APPROVE));
        }
      } catch (e) {
        emit(PBJStateFailure(message: e.toString()));
      }
    });

    //reject PBJ
    on<SendQPBJReject>((event, emit) async {
      print("on bloc sendQRPBJApprove");
      try {
        final request = await repo.rejectPBJ(
          noPermintaan: event.noPermintaan,
          comment: event.comment,
          pin: event.pin,
        );
        if (request.status == ResourceStatus.Success) {
          emit(PBJStateSuccess(
              message: request.message.toString(),
              type: PBJEStateActionType.REJECT));
        } else {
          emit(PBJStateFailure(
              message: request.message.toString(),
              type: PBJEStateActionType.REJECT));
        }
      } catch (e) {
        emit(PBJStateFailure(message: e.toString()));
      }
    });
  }
}
