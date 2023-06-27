import 'package:equatable/equatable.dart';

abstract class BadgeCounterStateNew extends Equatable {
  const BadgeCounterStateNew();

  @override
  List<Object?> get props => [];
}

class BadgeNotifStateInitial extends BadgeCounterStateNew {
  const BadgeNotifStateInitial();

  @override
  List<Object?> get props => [];
}

class BadgeNotifStateLoading extends BadgeCounterStateNew {
  const BadgeNotifStateLoading();

  @override
  List<Object?> get props => [];
}

class BadgeNotifStateSuccess extends BadgeCounterStateNew {
  final int totalMarketingClub;
  final int totalFinance;
  final int totalQS;
  final int totalLegal;
  final int totalPurchasing;
  final int totalBDD;
  final int totalProject;
  final int totalPromosi;
  final int totalMarketing;
  final int totalHRD;
  final int totalLanded;
  final int totalTown;
  final int totalPermit;
  final bool status;

  const BadgeNotifStateSuccess({
    required this.totalMarketingClub,
    required this.totalFinance,
    required this.totalQS,
    required this.totalLegal,
    required this.totalPurchasing,
    required this.totalBDD,
    required this.totalProject,
    required this.totalPromosi,
    required this.totalMarketing,
    required this.totalHRD,
    required this.totalLanded,
    required this.totalTown,
    required this.totalPermit,
    required this.status,
  });

  @override
  List<Object?> get props => [
        totalMarketingClub,
        totalFinance,
        totalQS,
        totalLegal,
        totalPurchasing,
        totalBDD,
        totalProject,
        totalPromosi,
        totalMarketing,
        totalHRD,
        totalLanded,
        totalTown,
        totalPermit,
        status,
      ];
}

class BadgeNotifStateFailure extends BadgeCounterStateNew {
  final String error;

  const BadgeNotifStateFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
