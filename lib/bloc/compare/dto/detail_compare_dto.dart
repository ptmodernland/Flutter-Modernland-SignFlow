class DetailCompareDTO {
  String? idCompare;
  String? noCompare;
  String? noRef;
  String? compare_date;
  String? desc_compare;
  String? attchFile;
  String? approve;
  String? status;
  String? namaUser;
  String? departemen;
  String? advancePayment;
  String? progressPayment;
  String? diskon;
  String? ppn;
  String? pajakReklame;

  DetailCompareDTO({
    required this.idCompare,
    required this.noCompare,
    this.noRef,
    required this.compare_date,
    required this.desc_compare,
    required this.attchFile,
    required this.approve,
    required this.status,
    required this.namaUser,
    required this.departemen,
    required this.advancePayment,
    required this.diskon,
    required this.pajakReklame,
    required this.progressPayment,
    required this.ppn,
  });

  factory DetailCompareDTO.fromJson(Map<String, dynamic> json) {
    return DetailCompareDTO(
      idCompare: json['id_compare'],
      noCompare: json['no_compare'],
      noRef: json['no_ref'],
      namaUser: json['namaUser'],
      compare_date: json['compare_date'],
      departemen: json['dept_user'],
      desc_compare: json['desc_compare'],
      advancePayment: json['advance_payment'],
      progressPayment: json['progres_payment'],
      attchFile: json['attch_lampiran'],
      approve: json['approve'],
      status: json['status'],
      diskon: json['diskon'],
      ppn: json['ppn'],
      pajakReklame: json['pajak_reklame'],
    );
  }
}
