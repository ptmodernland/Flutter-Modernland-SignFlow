class DetailPBJDTO {
  String noPermintaan;
  String tglPermintaan;
  String jenis;
  String attchFile;
  String approve;
  String status;
  String namaUser;
  String jabatan;
  String departemen;
  int lama;
  int pending;

  DetailPBJDTO({
    required this.noPermintaan,
    required this.tglPermintaan,
    required this.jenis,
    required this.attchFile,
    required this.approve,
    required this.status,
    required this.namaUser,
    required this.jabatan,
    required this.departemen,
    required this.lama,
    required this.pending,
  });

  factory DetailPBJDTO.fromJson(Map<String, dynamic> json) {
    return DetailPBJDTO(
      noPermintaan: json['no_permintaan'],
      tglPermintaan: json['tgl_permintaan'],
      jenis: json['jenis'],
      attchFile: json['attch_file'],
      approve: json['approve'],
      status: json['status'],
      namaUser: json['namaUser'],
      jabatan: json['jabatan'],
      departemen: json['departemen'],
      lama: json['lama'],
      pending: json['pending'],
    );
  }
}
