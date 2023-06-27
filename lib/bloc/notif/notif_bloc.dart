import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/bloc/notif/notif_event.dart';
import 'package:modernland_signflow/bloc/notif/notif_state.dart';
import 'package:modernland_signflow/repos/notif_repository.dart';

class NotifCoreBloc extends Bloc<NotifCoreEvent, NotifCoreState> {
  final NotifRepository _repo;

  NotifCoreBloc(this._repo) : super(NotifStateInitial()) {
    on<NotifEventInitial>((event, emit) async {
      emit(NotifStateInitial());
    });

    on<NotifEventCount>((event, emit) async {
      emit(NotifStateInitial());
      emit(NotifStateLoading());
      print("fetching notif counter");
      try {
        final request = await _repo.countNotif();
        if (request.data != null) {
          emit(NotifStateSuccess(
            totalKoordinasiAndIom: request.data?.totalKoordinasiAndIom ?? "",
            totalKoordinasi: request.data?.totalKoordinasi ?? "",
            totalCompare: request.data?.totalCompare ?? "",
            totalKasbon: request.data?.totalKasbon ?? "",
            totalRealisasi: request.data?.totalRealisasi ?? '',
            totalSemua: request.data?.totalSemua ?? "",
            totalPermohonan: request.data?.totalPermohonan ?? "",
            totalIom: request.data?.totalIom ?? "",
          ));
        } else {
          emit(NotifStateFailure(error: request.message ?? ""));
        }
      } catch (e) {
        emit(NotifStateFailure(error: e.toString() ?? ""));
      }
    });
  }
}
