/// id_kasbon : "1150"
/// no_kasbon : "BON/GC/01148"
/// jenis : "KASBON"
/// departemen : "RnD"
/// keperluan : "Es Kelapa Bang Sani"
/// status : "Y"
/// status_email : "T"
/// namaUser : "Staff 167"
/// approve : "168junction"
/// tgl_buat : "31-May-2023"

class ListAllKasbonDto {
  ListAllKasbonDto({
    String? idKasbon,
    String? noKasbon,
    String? jenis,
    String? departemen,
    String? keperluan,
    String? status,
    String? statusEmail,
    String? namaUser,
    String? approve,
    String? tglBuat,
  }) {
    _idKasbon = idKasbon;
    _noKasbon = noKasbon;
    _jenis = jenis;
    _departemen = departemen;
    _keperluan = keperluan;
    _status = status;
    _statusEmail = statusEmail;
    _namaUser = namaUser;
    _approve = approve;
    _tglBuat = tglBuat;
  }

  ListAllKasbonDto.fromJson(dynamic json) {
    _idKasbon = json['id_kasbon'];
    _noKasbon = json['no_kasbon'];
    _jenis = json['jenis'];
    _departemen = json['departemen'];
    _keperluan = json['keperluan'];
    _status = json['status'];
    _statusEmail = json['status_email'];
    _namaUser = json['namaUser'];
    _approve = json['approve'];
    _tglBuat = json['tgl_buat'];
  }

  String? _idKasbon;
  String? _noKasbon;
  String? _jenis;
  String? _departemen;
  String? _keperluan;
  String? _status;
  String? _statusEmail;
  String? _namaUser;
  String? _approve;
  String? _tglBuat;

  ListAllKasbonDto copyWith({
    String? idKasbon,
    String? noKasbon,
    String? jenis,
    String? departemen,
    String? keperluan,
    String? status,
    String? statusEmail,
    String? namaUser,
    String? approve,
    String? tglBuat,
  }) =>
      ListAllKasbonDto(
        idKasbon: idKasbon ?? _idKasbon,
        noKasbon: noKasbon ?? _noKasbon,
        jenis: jenis ?? _jenis,
        departemen: departemen ?? _departemen,
        keperluan: keperluan ?? _keperluan,
        status: status ?? _status,
        statusEmail: statusEmail ?? _statusEmail,
        namaUser: namaUser ?? _namaUser,
        approve: approve ?? _approve,
        tglBuat: tglBuat ?? _tglBuat,
      );

  String? get idKasbon => _idKasbon;

  String? get noKasbon => _noKasbon;

  String? get jenis => _jenis;

  String? get departemen => _departemen;

  String? get keperluan => _keperluan;

  String? get status => _status;

  String? get statusEmail => _statusEmail;

  String? get namaUser => _namaUser;

  String? get approve => _approve;

  String? get tglBuat => _tglBuat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_kasbon'] = _idKasbon;
    map['no_kasbon'] = _noKasbon;
    map['jenis'] = _jenis;
    map['departemen'] = _departemen;
    map['keperluan'] = _keperluan;
    map['status'] = _status;
    map['status_email'] = _statusEmail;
    map['namaUser'] = _namaUser;
    map['approve'] = _approve;
    map['tgl_buat'] = _tglBuat;
    return map;
  }
}
