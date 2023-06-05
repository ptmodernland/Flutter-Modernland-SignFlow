/// id_realisasi : "1077"
/// no_realisasi : "BPK/GC/01073"
/// no_kasbon : "BON/GC/01146"
/// tgl_realisasi : "30-May-2023"
/// attch_file : "x11.pdf"
/// approve : "168junction"
/// status : "Y"
/// status_email : "T"
/// namaUser : "Staff 167"
/// jabatan : "Staff"
/// departemen : "RnD"

class RealisasiDetailDto {
  RealisasiDetailDto({
    String? idRealisasi,
    String? noRealisasi,
    String? noKasbon,
    String? tglRealisasi,
    String? attchFile,
    String? approve,
    String? status,
    String? statusEmail,
    String? namaUser,
    String? jabatan,
    String? departemen,
  }) {
    _idRealisasi = idRealisasi;
    _noRealisasi = noRealisasi;
    _noKasbon = noKasbon;
    _tglRealisasi = tglRealisasi;
    _attchFile = attchFile;
    _approve = approve;
    _status = status;
    _statusEmail = statusEmail;
    _namaUser = namaUser;
    _jabatan = jabatan;
    _departemen = departemen;
  }

  RealisasiDetailDto.fromJson(dynamic json) {
    _idRealisasi = json['id_realisasi'];
    _noRealisasi = json['no_realisasi'];
    _noKasbon = json['no_kasbon'];
    _tglRealisasi = json['tgl_realisasi'];
    _attchFile = json['attch_file'];
    _approve = json['approve'];
    _status = json['status'];
    _statusEmail = json['status_email'];
    _namaUser = json['namaUser'];
    _jabatan = json['jabatan'];
    _departemen = json['departemen'];
  }

  String? _idRealisasi;
  String? _noRealisasi;
  String? _noKasbon;
  String? _tglRealisasi;
  String? _attchFile;
  String? _approve;
  String? _status;
  String? _statusEmail;
  String? _namaUser;
  String? _jabatan;
  String? _departemen;

  RealisasiDetailDto copyWith({
    String? idRealisasi,
    String? noRealisasi,
    String? noKasbon,
    String? tglRealisasi,
    String? attchFile,
    String? approve,
    String? status,
    String? statusEmail,
    String? namaUser,
    String? jabatan,
    String? departemen,
  }) =>
      RealisasiDetailDto(
        idRealisasi: idRealisasi ?? _idRealisasi,
        noRealisasi: noRealisasi ?? _noRealisasi,
        noKasbon: noKasbon ?? _noKasbon,
        tglRealisasi: tglRealisasi ?? _tglRealisasi,
        attchFile: attchFile ?? _attchFile,
        approve: approve ?? _approve,
        status: status ?? _status,
        statusEmail: statusEmail ?? _statusEmail,
        namaUser: namaUser ?? _namaUser,
        jabatan: jabatan ?? _jabatan,
        departemen: departemen ?? _departemen,
      );

  String? get idRealisasi => _idRealisasi;

  String? get noRealisasi => _noRealisasi;

  String? get noKasbon => _noKasbon;

  String? get tglRealisasi => _tglRealisasi;

  String? get attchFile => _attchFile;

  String? get approve => _approve;

  String? get status => _status;

  String? get statusEmail => _statusEmail;

  String? get namaUser => _namaUser;

  String? get jabatan => _jabatan;

  String? get departemen => _departemen;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_realisasi'] = _idRealisasi;
    map['no_realisasi'] = _noRealisasi;
    map['no_kasbon'] = _noKasbon;
    map['tgl_realisasi'] = _tglRealisasi;
    map['attch_file'] = _attchFile;
    map['approve'] = _approve;
    map['status'] = _status;
    map['status_email'] = _statusEmail;
    map['namaUser'] = _namaUser;
    map['jabatan'] = _jabatan;
    map['departemen'] = _departemen;
    return map;
  }
}
