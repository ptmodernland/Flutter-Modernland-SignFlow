
class NotifCounterDTO {
  String totalIom;
  String totalPermohonan;
  String totalCompare;
  String totalKasbon;
  String totalRealisasi;
  String totalKoordinasi;
  String totalKoordinasiAndIom;
  String totalSemua;
  bool status;

  NotifCounterDTO({
    required this.totalIom,
    required this.totalPermohonan,
    required this.totalCompare,
    required this.totalKasbon,
    required this.totalRealisasi,
    required this.totalKoordinasi,
    required this.totalKoordinasiAndIom,
    required this.totalSemua,
    required this.status,
  });

  factory NotifCounterDTO.fromJson(Map<String, dynamic> json) {
    return NotifCounterDTO(
      totalIom: json['total_iom'],
      totalPermohonan: json['total_permohonan'],
      totalCompare: json['total_compare'],
      totalKasbon: json['total_kasbon'],
      totalKoordinasi: json['total_koordinasi'],
      totalRealisasi: json['total_realisasi'],
      totalKoordinasiAndIom: json['total_koor_and_iom'],
      totalSemua: json['totalsemua'],
      status: json['status'],
    );
  }
}