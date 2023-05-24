import 'package:bwa_cozy/bloc/pbj/approval_main_page_event.dart';
import 'package:bwa_cozy/bloc/pbj/approval_main_page_state.dart';
import 'package:bwa_cozy/repos/approval_main_page_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApprovalMainPageBloc
    extends Bloc<ApprovalMainPageEvent, ApprovalMainPageState> {
  final ApprovalMainPageRepository _repo;

  ApprovalMainPageBloc(this._repo) : super(ApprovalMainPageStateInitial()) {
    on<RequestDataEvent>((event, emit) async {
      emit(ApprovalMainPageStateLoading());
      print("start bloc request");
      try {
        final request = await _repo.getPBJList();
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
    });
  }
}
