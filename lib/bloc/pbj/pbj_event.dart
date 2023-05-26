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
