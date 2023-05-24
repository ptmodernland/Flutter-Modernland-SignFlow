import 'package:bwa_cozy/bloc/pbj/approval_main_page_event.dart';
import 'package:bwa_cozy/bloc/pbj/approval_main_page_state.dart';
import 'package:bwa_cozy/repos/approval_main_page_repository.dart';
import 'package:bwa_cozy/util/enum/menu_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApprovalMainPageBloc
    extends Bloc<ApprovalMainPageEvent, ApprovalMainPageState> {
  final ApprovalMainPageRepository _repo;

  ApprovalMainPageBloc(this._repo) : super(ApprovalMainPageStateInitial()) {
    on<RequestDataEvent>((event, emit) async {
      emit(ApprovalMainPageStateLoading());
      print("start bloc request");
      if (event.payload == ApprovalListType.PBJ) {
        try {
          final request = await _repo.getPBJWaitingList();
          if (request.data != null) {
            emit(ApprovalMainPageStateSuccessListPBJ(datas: request.data!));
            print("success bloc approval_main_page");
          } else {
            emit(ApprovalMainPageStateFailure(error: request.message ?? ""));
          }
        } catch (e) {
          print("error occured on approval_main_page_bloc" + e.toString());
          emit(ApprovalMainPageStateFailure(error: e.toString() ?? ""));
        }
      }

      if (event.payload == ApprovalListType.COMPARE) {
        try {
          final request = await _repo.getCompareWaitingList();
          if (request.data != null) {
            emit(ApprovalMainPageStateSuccessListCompare(datas: request.data!));
            print("success bloc approval_main_page");
          } else {
            emit(ApprovalMainPageStateFailure(error: request.message ?? ""));
          }
        } catch (e) {
          print("error occured on approval_main_page_bloc" + e.toString());
          emit(ApprovalMainPageStateFailure(error: e.toString() ?? ""));
        }
      }

      if (event.payload == ApprovalListType.KASBON) {
        try {
          final request = await _repo.getKasbonWaitingList();
          if (request.data != null) {
            emit(ApprovalMainPageStateSuccessListKasbon(datas: request.data!));
            print("success bloc approval_main_page");
          } else {
            emit(ApprovalMainPageStateFailure(error: request.message ?? ""));
          }
        } catch (e) {
          print("error occured on approval_main_page_bloc" + e.toString());
          emit(ApprovalMainPageStateFailure(error: e.toString() ?? ""));
        }
      }
    });
  }
}
