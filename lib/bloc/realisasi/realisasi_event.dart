abstract class RealisasiEvent {}

class GetRealisasiDetailEvent extends RealisasiEvent {
  final String idRealisasi;

  GetRealisasiDetailEvent({
    required this.idRealisasi,
  });
}

class GetHistoryRealisasi extends RealisasiEvent {
  final String? startDate;
  final String? endDate;
  final String? year;
  final String? noPermintaan;
  final bool isAll;

  GetHistoryRealisasi(
      {this.startDate = null,
      this.endDate = null,
      this.year = null,
      this.noPermintaan = null,
      this.isAll = true});
}
