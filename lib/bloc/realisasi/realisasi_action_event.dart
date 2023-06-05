abstract class RealisasiActionEvent {}

class SendQRealisasiApprove extends RealisasiActionEvent {
  final String noRealisasi;
  final String idRealisasi;
  final String noKasbon;
  final String pin;
  final String comment;

  SendQRealisasiApprove({
    required this.noRealisasi,
    required this.pin,
    this.comment = "",
    required this.idRealisasi,
    required this.noKasbon,
  });
}

class SendQRealisasiReject extends RealisasiActionEvent {
  final String noRealisasi;
  final String idRealisasi;
  final String noKasbon;
  final String pin;
  final String comment;

  SendQRealisasiReject({
    required this.noRealisasi,
    required this.pin,
    this.comment = "",
    required this.idRealisasi,
    required this.noKasbon,
  });
}
