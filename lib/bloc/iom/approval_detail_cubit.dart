import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/bloc/_wrapper/response_wrapper.dart';
import 'package:modernland_signflow/bloc/iom/approval_state.dart';
import 'package:modernland_signflow/repos/iom/approval_repository.dart';

class ApprovalDetailCubit extends Cubit<ApprovalState> {
  final ApprovalRepository repository;

  ApprovalDetailCubit(this.repository) : super(ApprovalDetailLoading());

  Future<void> fetchApprovals(String idIom) async {
    final approvals = await repository.getDetailIOM(idIom);
    if (approvals.status == ResourceStatus.Success) {
      if (approvals.data != null) {
        emit(ApprovalDetailSuccess(approvals.data!));
      }
    }
    if (approvals.status == ResourceStatus.Loading) {
      emit(ApprovalDetailLoading());
    }

    if (approvals.status == ResourceStatus.Error) {
      emit(ApprovalError(
          'Failed to load approvals: ' + approvals.message.toString()));
    }
  }
}
