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

  NotifStateSuccess({
    this.totalPermohonan = "",
    this.totalCompare = "",
    this.totalKasbon = '',
    this.totalRealisasi = "",
    this.totalSemua = "",
    this.totalIom = "",
  });
}

class NotifStateFailure extends NotifCoreState {
  final String error;

  NotifStateFailure({required this.error});
}
