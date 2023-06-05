/// id_realisasi : "1077"
/// departemen : "RnD"
/// no_realisasi : "BPK/GC/01073"
/// no_kasbon : "BON/GC/01146"
/// jenis : "REALISASI"
/// status : "Y"
/// status_email : "T"
/// namaUser : "Staff 167"
/// approve : "168junction"
/// tgl_buat : "30-May-2023"

class RealisasiListDto {
  RealisasiListDto({
    String? idRealisasi,
    String? departemen,
    String? noRealisasi,
    String? noKasbon,
    String? jenis,
    String? status,
    String? statusEmail,
    String? namaUser,
    String? approve,
    String? tglBuat,
  }) {
    _idRealisasi = idRealisasi;
    _departemen = departemen;
    _noRealisasi = noRealisasi;
    _noKasbon = noKasbon;
    _jenis = jenis;
    _status = status;
    _statusEmail = statusEmail;
    _namaUser = namaUser;
    _approve = approve;
    _tglBuat = tglBuat;
  }

  RealisasiListDto.fromJson(dynamic json) {
    _idRealisasi = json['id_realisasi'];
    _departemen = json['departemen'];
    _noRealisasi = json['no_realisasi'];
    _noKasbon = json['no_kasbon'];
    _jenis = json['jenis'];
    _status = json['status'];
    _statusEmail = json['status_email'];
    _namaUser = json['namaUser'];
    _approve = json['approve'];
    _tglBuat = json['tgl_buat'];
  }

  String? _idRealisasi;
  String? _departemen;
  String? _noRealisasi;
  String? _noKasbon;
  String? _jenis;
  String? _status;
  String? _statusEmail;
  String? _namaUser;
  String? _approve;
  String? _tglBuat;

  RealisasiListDto copyWith({
    String? idRealisasi,
    String? departemen,
    String? noRealisasi,
    String? noKasbon,
    String? jenis,
    String? status,
    String? statusEmail,
    String? namaUser,
    String? approve,
    String? tglBuat,
  }) =>
      RealisasiListDto(
        idRealisasi: idRealisasi ?? _idRealisasi,
        departemen: departemen ?? _departemen,
        noRealisasi: noRealisasi ?? _noRealisasi,
        noKasbon: noKasbon ?? _noKasbon,
        jenis: jenis ?? _jenis,
        status: status ?? _status,
        statusEmail: statusEmail ?? _statusEmail,
        namaUser: namaUser ?? _namaUser,
        approve: approve ?? _approve,
        tglBuat: tglBuat ?? _tglBuat,
      );

  String? get idRealisasi => _idRealisasi;

  String? get departemen => _departemen;

  String? get noRealisasi => _noRealisasi;

  String? get noKasbon => _noKasbon;

  String? get jenis => _jenis;

  String? get status => _status;

  String? get statusEmail => _statusEmail;

  String? get namaUser => _namaUser;

  String? get approve => _approve;

  String? get tglBuat => _tglBuat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_realisasi'] = _idRealisasi;
    map['departemen'] = _departemen;
    map['no_realisasi'] = _noRealisasi;
    map['no_kasbon'] = _noKasbon;
    map['jenis'] = _jenis;
    map['status'] = _status;
    map['status_email'] = _statusEmail;
    map['namaUser'] = _namaUser;
    map['approve'] = _approve;
    map['tgl_buat'] = _tglBuat;
    return map;
  }
}
