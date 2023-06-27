import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/bloc/compare/compare_comment_event.dart';
import 'package:modernland_signflow/bloc/compare/compare_state.dart';
import 'package:modernland_signflow/repos/compare_repository.dart';

class CompareCommentBloc extends Bloc<CompareCommentEvent, CompareState> {
  final CompareRepository repo;

  CompareCommentBloc(this.repo) : super(CompareStateInitial()) {
    on<GetKomentarCompare>((event, emit) async {
      emit(CompareStateLoading());
      print("start bloc request");
      try {
        final request =
            await repo.getCommentCompare(noCompare: event.noCompare);
        if (request.data != null) {
          emit(CompareStateLoadCommentSuccess(datas: request.data!));
          print("success bloc approval_main_page");
        } else {
          emit(CompareStateFailure(
              type: CompareEActionType.SHOW_KOMENTAR,
              message: request.message ?? ""));
        }
      } catch (e) {
        print("error occured on approval_main_page_bloc" + e.toString());
        emit(CompareStateFailure(
            message: e.toString(), type: CompareEActionType.SHOW_KOMENTAR));
      }
    });
  }
}
