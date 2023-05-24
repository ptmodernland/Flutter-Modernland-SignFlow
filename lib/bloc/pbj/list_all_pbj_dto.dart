class ListAllPbjDTO {
  final String noPermintaan;
  final String jenis;
  final String status;
  final String approve;
  final String tglPermintaan;

  ListAllPbjDTO({
    required this.noPermintaan,
    required this.jenis,
    required this.status,
    required this.approve,
    required this.tglPermintaan,
  });

  factory ListAllPbjDTO.fromJson(Map<String, dynamic> json) {
    return ListAllPbjDTO(
      noPermintaan: json['no_permintaan'],
      jenis: json['jenis'],
      status: json['status'],
      approve: json['approve'],
      tglPermintaan: json['tgl_permintaan'],
    );
  }
}
