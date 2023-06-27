import 'package:bwa_cozy/util/enum/menu_type.dart';
import 'package:equatable/equatable.dart';

abstract class ApprovalMainPageEvent extends Equatable {}

class ApprovalMainPageInitialEvent extends ApprovalMainPageEvent {
  @override
  List<Object?> get props => [];
}

class RequestDataEvent extends ApprovalMainPageEvent {
  final ApprovalListType payload;

  RequestDataEvent(this.payload);

  @override
  List<Object?> get props => [payload];
}

class RequestPBJDetailEvent extends ApprovalMainPageEvent {
  final String noPermintaan;

  RequestPBJDetailEvent(this.noPermintaan);

  @override
  List<Object?> get props => [noPermintaan];
}


