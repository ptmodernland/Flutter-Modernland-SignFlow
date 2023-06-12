import 'package:bwa_cozy/bloc/compare/compare_event.dart';
import 'package:bwa_cozy/bloc/compare/compare_state.dart';
import 'package:bwa_cozy/repos/compare_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompareBloc extends Bloc<CompareEvent, CompareState> {
  final CompareRepository repo;

  CompareBloc(this.repo) : super(CompareStateInitial()) {
    on<GetHistoryCompare>((event, emit) async {
      emit(CompareStateLoading());
      print("start bloc request");
      try {
        final request = await repo.getHistoryCompare(
          startDate: event.startDate,
          endDate: event.endDate,
          noPermintaan: event.noPermintaan,
        );
        if (request.data != null) {
          emit(CompareStateLoadHistorySuccess(datas: request.data!));
          print("success bloc approval_main_page");
        } else {
          emit(CompareStateFailure(
              type: CompareEActionType.SHOW_HISTORY,
              message: request.message ?? ""));
        }
      } catch (e) {
        print("error occured on approval_main_page_bloc" + e.toString());
        emit(CompareStateFailure(
            message: e.toString(), type: CompareEActionType.SHOW_HISTORY));
      }
    });

    on<GetCompareDetailEvent>((event, emit) async {
      try {
        final request = await repo.getCompareDetail(event.idCompare);
        if (request.data != null) {
          emit(CompareDetailSuccess(data: request.data!));
          print("success bloc approval_detail_pbj");
        } else {
          emit(CompareStateFailure(
              message: request.message ?? "",
              type: CompareEActionType.LOAD_DETAIL));
        }
      } catch (e) {
        print("error occured on approval pbj detail bloc" + e.toString());
        emit(CompareStateFailure(
            message: e.toString() ?? "", type: CompareEActionType.LOAD_DETAIL));
      }
    });

  }
}
