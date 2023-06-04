abstract class KasbonActionEvent {}

class SendApprove extends KasbonActionEvent {
  final String noKasbon;
  final String pin;
  final String comment;

  SendApprove({this.noKasbon = "", this.pin = "", this.comment = "-"});
}

class SendReject extends KasbonActionEvent {
  final String noKasbon;
  final String pin;
  final String comment;

  SendReject({this.noKasbon = "", this.pin = "", this.comment = "-"});
}
