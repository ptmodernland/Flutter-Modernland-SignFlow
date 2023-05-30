abstract class CompareEvent {}

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

class GetHistoryCompare extends CompareEvent {
  final String? startDate;
  final String? endDate;
  final String? year;
  final String? noPermintaan;
  final bool isAll;

  GetHistoryCompare(
      {this.startDate = null,
      this.endDate = null,
      this.year = null,
      this.noPermintaan = null,
      this.isAll = true});
}
