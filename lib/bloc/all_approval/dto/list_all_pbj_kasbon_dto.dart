class ListAllKasbonDTO {
  final String id_kasbon;
  final String no_kasbon;
  final String jenis;
  final String status;
  final String namaUser;
  final String approve;
  final String tglPermintaan;

  ListAllKasbonDTO({
    required this.id_kasbon,
    required this.no_kasbon,
    required this.jenis,
    required this.status,
    required this.namaUser,
    required this.approve,
    required this.tglPermintaan,
  });

  factory ListAllKasbonDTO.fromJson(Map<String, dynamic> json) {
    return ListAllKasbonDTO(
      id_kasbon: json['id_kasbon'],
      no_kasbon: json['no_kasbon'],
      jenis: json['jenis'],
      status: json['status'],
      namaUser: json['namaUser'],
      approve: json['approve'],
      tglPermintaan: json['tgl_buat'],
    );
  }
}
