import 'package:bwa_cozy/repos/stream/Orderbook_dto.dart';
import 'package:bwa_cozy/repos/stream/shareholder_transaction_dto.dart';
import 'package:bwa_cozy/repos/stream/stream_paging_dto.dart';

abstract class StreamState {}

//This will used to consider what success/failure state came from
enum StreamEActionType {
  LOAD_DETAIL,
  SHOW_HISTORY,
  SHOW_KOMENTAR,
  APPROVE,
  REJECT,
  RECOMMEND,
  DEFAULT,
}

class StreamStateInitial extends StreamState {}

class StreamStateLoading extends StreamState {
  final String progress;
  final StreamEActionType type;

  StreamStateLoading(
      {this.progress = "", this.type = StreamEActionType.DEFAULT});
}

class StreamStateLoadSuccess extends StreamState {
  final List<StreamData> datas;

  StreamStateLoadSuccess({this.datas = const []});
}

class StreamStateLoadShareholder extends StreamState {
  final List<ShareholderMovementDTO> datas;

  StreamStateLoadShareholder({this.datas = const []});
}

class StreamStateOrderbookSuccess extends StreamState {
  final OrderbookDto datas;

  StreamStateOrderbookSuccess({required this.datas});
}

class StreamStateFailure extends StreamState {
  final String message;
  final StreamEActionType type;

  StreamStateFailure({
    this.message = "",
    this.type = StreamEActionType.REJECT,
  });
}
