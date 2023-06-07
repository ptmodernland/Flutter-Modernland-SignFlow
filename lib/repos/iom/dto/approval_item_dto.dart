class ApprovalItem {
  final String? idIom;
  final String? namaUser;
  final String? departemen;
  final String? nomor;
  final String? perihal;
  final String? approve;
  final String? tanggal;
  final String? status;
  final String? statusEmail;
  final String? kordinasi;
  final String? kategoriIom;
  final String? dari;

  ApprovalItem({
    required this.idIom,
    required this.namaUser,
    required this.departemen,
    required this.nomor,
    required this.perihal,
    required this.tanggal,
    required this.approve,
    required this.status,
    required this.statusEmail,
    required this.kordinasi,
    required this.kategoriIom,
    required this.dari,
  });

  factory ApprovalItem.fromJson(Map<String, dynamic> json) {
    return ApprovalItem(
      idIom: json['id_iom'],
      namaUser: json['namaUser'],
      departemen: json['departemen'],
      nomor: json['nomor'],
      tanggal: json['tanggal'],
      perihal: json['perihal'],
      approve: json['approve'],
      status: json['status'],
      statusEmail: json['status_email'],
      kordinasi: json['kordinasi'],
      kategoriIom: json['kategori_iom'],
      dari: json['dari'],
    );
  }
}
