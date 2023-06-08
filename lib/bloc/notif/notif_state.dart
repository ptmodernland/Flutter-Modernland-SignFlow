abstract class NotifCoreState {}

class NotifStateInitial extends NotifCoreState {}

class NotifStateLoading extends NotifCoreState {}

class NotifStateSuccess extends NotifCoreState {
  final String totalPermohonan;
  final String totalCompare;
  final String totalKasbon;
  final String totalRealisasi;
  final String totalSemua;
  final String totalIom;
  final String totalKoordinasi;
  final String totalKoordinasiAndIom;

  NotifStateSuccess({
    this.totalPermohonan = "",
    this.totalCompare = "",
    this.totalKasbon = '',
    this.totalRealisasi = "",
    this.totalSemua = "",
    this.totalIom = "",
    this.totalKoordinasi = "",
    this.totalKoordinasiAndIom = "",
  });
}

class NotifStateFailure extends NotifCoreState {
  final String error;

  NotifStateFailure({required this.error});
}
