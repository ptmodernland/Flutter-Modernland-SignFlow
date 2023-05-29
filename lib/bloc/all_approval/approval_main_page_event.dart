import 'package:bwa_cozy/util/enum/menu_type.dart';

abstract class ApprovalMainPageEvent {}

class RequestDataEvent extends ApprovalMainPageEvent {
  final ApprovalListType payload;

  RequestDataEvent(this.payload);
}

class RequestPBJDetailEvent extends ApprovalMainPageEvent {
  final String noPermintaan;

  RequestPBJDetailEvent(this.noPermintaan);
}


