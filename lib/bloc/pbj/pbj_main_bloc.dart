import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/bloc/_wrapper/response_wrapper.dart';
import 'package:modernland_signflow/bloc/pbj/pbj_event.dart';
import 'package:modernland_signflow/bloc/pbj/pbj_state.dart';
import 'package:modernland_signflow/repos/pbj_repository.dart';

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
      emit(PBJStateLoading());
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

    //get PBJ History
    on<GetHistoryPBJ>((event, emit) async {
      emit(PBJStateLoading());
      print("start bloc request");
      try {
        final request = await repo.getHistoryPBJ();
        if (request.data != null) {
          emit(PBJStateLoadHistorySuccess(datas: request.data!));
          print("success bloc approval_main_page");
        } else {
          emit(PBJStateFailure(
              type: PBJEStateActionType.SHOW_HISTORY,
              message: request.message ?? ""));
        }
      } catch (e) {
        print("error occured on approval_main_page_bloc" + e.toString());
        emit(PBJStateFailure(
            message: e.toString(), type: PBJEStateActionType.SHOW_HISTORY));
      }
    });

  }
}
