import 'package:flutter_bloc/flutter_bloc.dart';

class FilterCompareCubit extends Cubit<FilterCompareOptions> {
  FilterCompareCubit() : super(FilterCompareOptions());

  void setFilterOptions(FilterCompareOptions options) {
    emit(options);
  }

  void setFilterKeyword(String keyword) {
    final currentOptions = state;
    final updatedOptions = currentOptions.copyWith(filterKeyword: keyword);
    emit(updatedOptions);
  }

  void setStartDate(DateTime startDate) {
    final currentOptions = state;
    final updatedOptions = currentOptions.copyWith(startDate: startDate);
    emit(updatedOptions);
  }

  void setEndDate(DateTime endDate) {
    final currentOptions = state;
    final updatedOptions = currentOptions.copyWith(endDate: endDate);
    emit(updatedOptions);
  }

  void setApplied(bool isApplied) {
    final currentOptions = state;
    final updatedOptions = currentOptions.copyWith(isApplied: isApplied);
    emit(updatedOptions);
  }

  void clearFilters() {
    emit(FilterCompareOptions());
  }
}

class FilterCompareOptions {
  final String filterKeyword;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isApplied;

  FilterCompareOptions({
    this.filterKeyword = '',
    this.startDate,
    this.endDate,
    this.isApplied,
  });

  FilterCompareOptions copyWith({
    String? filterKeyword,
    DateTime? startDate,
    DateTime? endDate,
    bool? isApplied,
  }) {
    return FilterCompareOptions(
        filterKeyword: filterKeyword ?? this.filterKeyword,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        isApplied: isApplied ?? this.isApplied);
  }
}
