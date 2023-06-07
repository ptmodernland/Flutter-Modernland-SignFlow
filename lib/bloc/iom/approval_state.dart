import 'package:bwa_cozy/repos/iom/dto/Iom_detail_dto.dart';
import 'package:bwa_cozy/repos/iom/dto/Iom_log_dto.dart';
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

// for load comment
class ApprovalCommentSuccess extends ApprovalState {
  final List<IomCommentDto> comments;

  ApprovalCommentSuccess({required this.comments});
}

class ApprovalCommentError extends ApprovalState {
  final String message;

  ApprovalCommentError(this.message);
}

// for log
class ApprovalLogSuccess extends ApprovalState {
  final List<IomLogDto> logs;

  ApprovalLogSuccess({required this.logs});
}

class ApprovalLogError extends ApprovalState {
  final String message;

  ApprovalLogError(this.message);
}
