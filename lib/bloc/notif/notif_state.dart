import 'package:equatable/equatable.dart';

abstract class NotifCoreState extends Equatable {
  const NotifCoreState();

  @override
  List<Object?> get props => [];
}

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

  const NotifStateSuccess({
    this.totalPermohonan = '',
    this.totalCompare = '',
    this.totalKasbon = '',
    this.totalRealisasi = '',
    this.totalSemua = '',
    this.totalIom = '',
    this.totalKoordinasi = '',
    this.totalKoordinasiAndIom = '',
  });

  @override
  List<Object?> get props => [
        totalPermohonan,
        totalCompare,
        totalKasbon,
        totalRealisasi,
        totalSemua,
        totalIom,
        totalKoordinasi,
        totalKoordinasiAndIom,
      ];
}

class NotifStateFailure extends NotifCoreState {
  final String error;

  const NotifStateFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
