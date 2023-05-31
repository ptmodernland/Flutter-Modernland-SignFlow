class ListAllCompareDTO {
  final String? idCompare;
  final String? noCompare;
  final String? namaUser;
  final String? descCompare;
  final String? approve;
  final String? tglPermintaan;
  final String? department;
  final String? status;
  final String? statusEmail;

  ListAllCompareDTO(
      {required this.idCompare,
      required this.noCompare,
      required this.namaUser,
      required this.descCompare,
      required this.approve,
      required this.department,
      required this.tglPermintaan,
      required this.status,
      required this.statusEmail});

  factory ListAllCompareDTO.fromJson(Map<String, dynamic> json) {
    return ListAllCompareDTO(
      idCompare: json['id_compare'],
      noCompare: json['no_compare'],
      namaUser: json['namaUser'] ?? null,
      descCompare: json['desc_compare'],
      department: json['departemen'] ?? null,
      approve: json['approve'],
      tglPermintaan: json['tgl_permintaan'],
      status: json['status'],
      statusEmail: json['status_email'],
    );
  }
}
