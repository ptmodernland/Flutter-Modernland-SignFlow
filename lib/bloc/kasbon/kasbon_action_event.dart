abstract class CompareActionEvent {}

class SendQCompareApprove extends CompareActionEvent {
  final String noPermintaan;
  final String pin;
  final String comment;

  SendQCompareApprove(
      {this.noPermintaan = "", this.pin = "", this.comment = "-"});
}

class SendQCompareReject extends CompareActionEvent {
  final String nomorCompare;
  final String pin;
  final String comment;

  SendQCompareReject(
      {this.nomorCompare = "", this.pin = "", this.comment = "-"});
}
