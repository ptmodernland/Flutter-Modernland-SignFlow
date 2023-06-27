import 'package:bwa_cozy/bloc/iomcategorycounter/badge_counter_state_new.dart';
import 'package:bwa_cozy/repos/badge_counter_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BadgeCounterCubit extends Cubit<BadgeCounterStateNew> {
  final BadgeCounterRepository repository;

  BadgeCounterCubit(this.repository) : super(BadgeNotifStateInitial());

  Future<void> fetchBadgeCounter() async {
    try {
      emit(BadgeNotifStateLoading());
      final badgeCounter = await repository.fetchBadgeCounter();
      emit(BadgeNotifStateSuccess(
          totalMarketingClub: badgeCounter.totalMarketingClub,
          totalFinance: badgeCounter.totalFinance,
          totalQS: badgeCounter.totalQS,
          totalLegal: badgeCounter.totalLegal,
          totalPurchasing: badgeCounter.totalPurchasing,
          totalBDD: badgeCounter.totalBDD,
          totalProject: badgeCounter.totalProject,
          totalPromosi: badgeCounter.totalPromosi,
          totalMarketing: badgeCounter.totalMarketing,
          totalHRD: badgeCounter.totalHRD,
          totalLanded: badgeCounter.totalLanded,
          totalTown: badgeCounter.totalTown,
          totalPermit: badgeCounter.totalPermit,
          status: badgeCounter.status));
    } catch (e) {
      emit(BadgeNotifStateFailure(error: e.toString()));
    }
  }
}
