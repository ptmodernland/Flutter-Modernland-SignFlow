import 'package:bwa_cozy/bloc/iomcategorycounter/badge_counter_state.dart';
import 'package:bwa_cozy/repos/badge_counter_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BadgeCounterCubit extends Cubit<BadgeCounterState> {
  final BadgeCounterRepository repository;

  BadgeCounterCubit(this.repository)
      : super(BadgeCounterState(
          totalMarketingClub: 0,
          totalFinance: 0,
          totalQS: 0,
          totalLegal: 0,
          totalPurchasing: 0,
          totalBDD: 0,
          totalProject: 0,
          totalPromosi: 0,
          totalMarketing: 0,
          totalHRD: 0,
          totalLanded: 0,
          totalTown: 0,
          totalPermit: 0,
          status: false,
        ));

  Future<void> fetchBadgeCounter() async {
    try {
      final badgeCounter = await repository.fetchBadgeCounter();
      emit(badgeCounter);
    } catch (e) {
      // Handle error
    }
  }
}
