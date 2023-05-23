
class NotifCounterDTO {
  String totalIom;
  String totalPermohonan;
  String totalCompare;
  String totalKasbon;
  String totalRealisasi;
  String totalSemua;
  bool status;

  NotifCounterDTO({
    required this.totalIom,
    required this.totalPermohonan,
    required this.totalCompare,
    required this.totalKasbon,
    required this.totalRealisasi,
    required this.totalSemua,
    required this.status,
  });

  factory NotifCounterDTO.fromJson(Map<String, dynamic> json) {
    return NotifCounterDTO(
      totalIom: json['total_iom'],
      totalPermohonan: json['total_permohonan'],
      totalCompare: json['total_compare'],
      totalKasbon: json['total_kasbon'],
      totalRealisasi: json['total_realisasi'],
      totalSemua: json['totalsemua'],
      status: json['status'],
    );
  }
}