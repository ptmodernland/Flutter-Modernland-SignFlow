class ListPBJCommentDTO {
  final String namaUser;
  final String status;
  final String komentar;
  final String approve;
  final String statusApprove;
  final String tglPermintaan;

  ListPBJCommentDTO({
    required this.namaUser,
    required this.komentar,
    required this.status,
    required this.approve,
    required this.statusApprove,
    required this.tglPermintaan,
  });

  factory ListPBJCommentDTO.fromJson(Map<String, dynamic> json) {
    return ListPBJCommentDTO(
      namaUser: json['namaUser'],
      status: json['status'],
      komentar: json['komen'] ?? '',
      // Provide default value when komentar is missing
      approve: json['approve'],
      statusApprove: json['status_approve'],
      tglPermintaan: json['tgl'],
    );
  }
}
