import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/bloc/kasbon/kasbon_event.dart';
import 'package:modernland_signflow/bloc/kasbon/kasbon_state.dart';
import 'package:modernland_signflow/repos/kasbon_repository.dart';

class KasbonBloc extends Bloc<KasbonEvent, KasbonState> {
  final KasbonRepository repo;

  KasbonBloc(this.repo) : super(KasbonStateInitial()) {
    on<GetHistoryKasbon>((event, emit) async {
      emit(KasbonStateLoading());
      print("start bloc request");
      try {
        final request = await repo.getHistoryKasbon();
        if (request.data != null) {
          emit(KasbonStateLoadHistorySuccess(datas: request.data!));
          print("success bloc approval_main_page");
        } else {
          emit(KasbonStateFailure(
              type: KasbonEActionType.SHOW_HISTORY,
              message: request.message ?? ""));
        }
      } catch (e) {
        print("error occured on approval_main_page_bloc" + e.toString());
        emit(KasbonStateFailure(
            message: e.toString(), type: KasbonEActionType.SHOW_HISTORY));
      }
    });

    on<GetKasbonDetailEvent>((event, emit) async {
      try {
        final request = await repo.getKasbonDetail(event.idCompare);
        if (request.data != null) {
          emit(KasbonDetailSuccess(data: request.data!));
          print("success bloc approval_detail_pbj");
        } else {
          emit(KasbonStateFailure(
              message: request.message ?? "",
              type: KasbonEActionType.LOAD_DETAIL));
        }
      } catch (e) {
        print("error occured on approval pbj detail bloc" + e.toString());
        emit(KasbonStateFailure(
            message: e.toString() ?? "", type: KasbonEActionType.LOAD_DETAIL));
      }
    });
  }
}
