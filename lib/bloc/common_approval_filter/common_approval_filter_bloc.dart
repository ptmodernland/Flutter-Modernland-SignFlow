import 'package:bwa_cozy/bloc/common_approval_filter/common_approval_filter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBloc extends Cubit<FilterState> {
  FilterBloc() : super(FilterState());

  void setSelectedOption(String option) {
    emit(state.copyWith(submitted: false, selectedOption: option));
  }

  void setStartDateTime(DateTime dateTime) {
    emit(state.copyWith(
      submitted: false,
      endDateTime: state.endDateTime,
      startDateTime: dateTime,
    ));
  }

  void setEndDateTime(DateTime dateTime) {
    emit(state.copyWith(
      submitted: false,
      startDateTime: state.startDateTime,
      endDateTime: dateTime,
    ));
  }

  void setNomorRequest(String nomorRequest) {
    emit(state.copyWith(
        submitted: false,
        nomorRequest: nomorRequest,
        startDateTime: null,
        endDateTime: null));
  }

  void submitForm() {
    // Perform any necessary actions before submitting the form
    // such as API calls, database operations, etc.

    if (state.selectedOption == "Tanggal Buat") {
      print("selected option is Tanggal Buat");
      emit(state.copyWith(
        submitted: true,
        startDateTime: state.startDateTime,
        endDateTime: state.endDateTime,
        nomorRequest: null,
      ));
    }

    if (state.selectedOption == "All") {
      print("selected option is All");
      emit(state.copyWith(
        submitted: true,
        startDateTime: null,
        endDateTime: null,
        nomorRequest: null,
      ));
      print(state.toString());
    }

    if (state.selectedOption == "Nomor Request") {
      print("selected option is Nomor Request");
      emit(state.copyWith(
        submitted: true,
        startDateTime: null,
        endDateTime: null,
        nomorRequest: state.nomorRequest,
      ));
    }
  }
}
