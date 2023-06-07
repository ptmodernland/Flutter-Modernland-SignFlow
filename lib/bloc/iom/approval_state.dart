import 'package:bwa_cozy/repos/iom/dto/Iom_detail_dto.dart';
import 'package:bwa_cozy/repos/iom/dto/approval_item_dto.dart';
import 'package:bwa_cozy/repos/iom/dto/iom_comment_dto.dart';

class ApprovalState {}

class ApprovalLoading extends ApprovalState {}

class ApprovalEmpty extends ApprovalState {}

class ApprovalSuccess extends ApprovalState {
  final List<ApprovalItem> approvals;

  ApprovalSuccess(this.approvals);
}

//FOR LOADING DETAIL
class ApprovalDetailSuccess extends ApprovalState {
  final IomDetailDto detailData;

  ApprovalDetailSuccess(this.detailData);
}

class ApprovalDetailLoading extends ApprovalState {
  ApprovalDetailLoading();
}

class ApprovalDetailError extends ApprovalState {
  final String message;

  ApprovalDetailError(this.message);
}

class ApprovalError extends ApprovalState {
  final String message;

  ApprovalError(this.message);
}

class ApprovalCommentSuccess extends ApprovalState {
  final List<IomCommentDto> comments;

  ApprovalCommentSuccess({required this.comments});
}

class ApprovalCommentError extends ApprovalState {
  final String message;

  ApprovalCommentError(this.message);
}
