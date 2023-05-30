abstract class PBJEvent {}

class SendQPBJApprove extends PBJEvent {
  final String noPermintaan;
  final String pin;
  final String comment;

  SendQPBJApprove({this.noPermintaan = "", this.pin = "", this.comment = "-"});
}

class SendQPBJReject extends PBJEvent {
  final String noPermintaan;
  final String pin;
  final String comment;

  SendQPBJReject({this.noPermintaan = "", this.pin = "", this.comment = "-"});
}

class GetHistoryPBJ extends PBJEvent {
  final String? startDate;
  final String? endDate;
  final String? year;
  final String? noPermintaan;
  final bool isAll;

  GetHistoryPBJ(
      {this.startDate = null,
      this.endDate = null,
      this.year = null,
      this.noPermintaan = null,
      this.isAll = true});
}
