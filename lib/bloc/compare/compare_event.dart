abstract class CompareEvent {}

class SendQCompareApprove extends CompareEvent {
  final String noPermintaan;
  final String pin;
  final String comment;

  SendQCompareApprove(
      {this.noPermintaan = "", this.pin = "", this.comment = "-"});
}

class SendQCompareReject extends CompareEvent {
  final String nomorCompare;
  final String pin;
  final String comment;

  SendQCompareReject(
      {this.nomorCompare = "", this.pin = "", this.comment = "-"});
}

class GetKomentarCompare extends CompareEvent {
  final String? noPermintaan;

  GetKomentarCompare({
    this.noPermintaan = null,
  });
}

class GetCompareDetailEvent extends CompareEvent {
  final String idCompare;

  GetCompareDetailEvent({
    required this.idCompare,
  });
}

class GetHistoryPBJ extends CompareEvent {
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
