/// no_kasbon : "BON/GC/01150"
/// tgl_kasbon : "31-May-2023"
/// attch_file : "Permohonan-Barang-Jasa.pdf"
/// approve : "168junction"
/// status : "Y"
/// status_email : "T"
/// namaUser : "Staff 167"
/// jabatan : "Staff"
/// departemen : "RnD"
/// jumlah : "Rp.0"
/// keterangan : "Es Kelapa Bang Tsani"

class KasbonDetailDto {
  KasbonDetailDto({
    String? noKasbon,
    String? tglKasbon,
    String? attchFile,
    String? approve,
    String? status,
    String? statusEmail,
    String? namaUser,
    String? jabatan,
    String? departemen,
    String? jumlah,
    String? keterangan,
  }) {
    _noKasbon = noKasbon;
    _tglKasbon = tglKasbon;
    _attchFile = attchFile;
    _approve = approve;
    _status = status;
    _statusEmail = statusEmail;
    _namaUser = namaUser;
    _jabatan = jabatan;
    _departemen = departemen;
    _jumlah = jumlah;
    _keterangan = keterangan;
  }

  KasbonDetailDto.fromJson(dynamic json) {
    _noKasbon = json['no_kasbon'];
    _tglKasbon = json['tgl_kasbon'];
    _attchFile = json['attch_file'];
    _approve = json['approve'];
    _status = json['status'];
    _statusEmail = json['status_email'];
    _namaUser = json['namaUser'];
    _jabatan = json['jabatan'];
    _departemen = json['departemen'];
    _jumlah = json['jumlah'];
    _keterangan = json['keterangan'];
  }

  String? _noKasbon;
  String? _tglKasbon;
  String? _attchFile;
  String? _approve;
  String? _status;
  String? _statusEmail;
  String? _namaUser;
  String? _jabatan;
  String? _departemen;
  String? _jumlah;
  String? _keterangan;

  KasbonDetailDto copyWith({
    String? noKasbon,
    String? tglKasbon,
    String? attchFile,
    String? approve,
    String? status,
    String? statusEmail,
    String? namaUser,
    String? jabatan,
    String? departemen,
    String? jumlah,
    String? keterangan,
  }) =>
      KasbonDetailDto(
        noKasbon: noKasbon ?? _noKasbon,
        tglKasbon: tglKasbon ?? _tglKasbon,
        attchFile: attchFile ?? _attchFile,
        approve: approve ?? _approve,
        status: status ?? _status,
        statusEmail: statusEmail ?? _statusEmail,
        namaUser: namaUser ?? _namaUser,
        jabatan: jabatan ?? _jabatan,
        departemen: departemen ?? _departemen,
        jumlah: jumlah ?? _jumlah,
        keterangan: keterangan ?? _keterangan,
      );

  String? get noKasbon => _noKasbon;

  String? get tglKasbon => _tglKasbon;

  String? get attchFile => _attchFile;

  String? get approve => _approve;

  String? get status => _status;

  String? get statusEmail => _statusEmail;

  String? get namaUser => _namaUser;

  String? get jabatan => _jabatan;

  String? get departemen => _departemen;

  String? get jumlah => _jumlah;

  String? get keterangan => _keterangan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['no_kasbon'] = _noKasbon;
    map['tgl_kasbon'] = _tglKasbon;
    map['attch_file'] = _attchFile;
    map['approve'] = _approve;
    map['status'] = _status;
    map['status_email'] = _statusEmail;
    map['namaUser'] = _namaUser;
    map['jabatan'] = _jabatan;
    map['departemen'] = _departemen;
    map['jumlah'] = _jumlah;
    map['keterangan'] = _keterangan;
    return map;
  }
}
