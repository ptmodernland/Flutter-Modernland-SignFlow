class FilterState {
  final String selectedOption;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final String? nomorRequest;
  final bool submitted;

  FilterState({
    this.selectedOption = 'All',
    this.startDateTime,
    this.endDateTime,
    this.nomorRequest = '',
    this.submitted = false,
  });

  FilterState copyWith({
    String? selectedOption,
    DateTime? startDateTime,
    DateTime? endDateTime,
    String? nomorRequest,
    bool? submitted,
  }) {
    return FilterState(
      selectedOption: selectedOption ?? this.selectedOption,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      nomorRequest: nomorRequest,
      submitted: submitted ?? false,
    );
  }
}
