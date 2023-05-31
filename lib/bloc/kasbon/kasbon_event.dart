abstract class KasbonEvent {}

class GetKasbonDetailEvent extends KasbonEvent {
  final String idCompare;

  GetKasbonDetailEvent({
    required this.idCompare,
  });
}

class GetHistoryKasbon extends KasbonEvent {
  final String? startDate;
  final String? endDate;
  final String? year;
  final String? noPermintaan;
  final bool isAll;

  GetHistoryKasbon(
      {this.startDate = null,
      this.endDate = null,
      this.year = null,
      this.noPermintaan = null,
      this.isAll = true});
}
