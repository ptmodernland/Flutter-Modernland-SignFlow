class ListAllCompareDTO {
  final String? noPermintaan;
  final String? namaUser;
  final String? jenis;
  final String? status;
  final String? approve;
  final String? tglPermintaan;
  final String? department;

  ListAllCompareDTO({
    required this.noPermintaan,
    required this.namaUser,
    required this.jenis,
    required this.status,
    required this.approve,
    required this.tglPermintaan,
    required this.department,
  });

  factory ListAllCompareDTO.fromJson(Map<String, dynamic> json) {
    return ListAllCompareDTO(
      noPermintaan: json['no_permintaan'],
      namaUser: json['namaUser'],
      jenis: json['jenis'],
      department: json['departemen'],
      status: json['status'],
      approve: json['approve'],
      tglPermintaan: json['tgl_permintaan'],
    );
  }
}
