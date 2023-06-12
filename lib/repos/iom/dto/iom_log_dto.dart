/// namaUser : "Jillan Rusli"
/// departemen : "Club Billionaire"
/// tgl_log : "03-February-2021"
/// id_log : "10"
/// status_log_iom : "Created IOM"
/// nomor : "0027/BC/II/2021 (R)"
/// id_iom : "182"
/// username : "jillan.rusli"

class IomLogDto {
  IomLogDto({
    String? namaUser,
    String? departemen,
    String? tglLog,
    String? idLog,
    String? statusLogIom,
    String? nomor,
    String? idIom,
    String? username,
  }) {
    _namaUser = namaUser;
    _departemen = departemen;
    _tglLog = tglLog;
    _idLog = idLog;
    _statusLogIom = statusLogIom;
    _nomor = nomor;
    _idIom = idIom;
    _username = username;
  }

  IomLogDto.fromJson(dynamic json) {
    _namaUser = json['namaUser'];
    _departemen = json['departemen'];
    _tglLog = json['tgl_log'];
    _idLog = json['id_log'];
    _statusLogIom = json['status_log_iom'];
    _nomor = json['nomor'];
    _idIom = json['id_iom'];
    _username = json['username'];
  }

  String? _namaUser;
  String? _departemen;
  String? _tglLog;
  String? _idLog;
  String? _statusLogIom;
  String? _nomor;
  String? _idIom;
  String? _username;

  IomLogDto copyWith({
    String? namaUser,
    String? departemen,
    String? tglLog,
    String? idLog,
    String? statusLogIom,
    String? nomor,
    String? idIom,
    String? username,
  }) =>
      IomLogDto(
        namaUser: namaUser ?? _namaUser,
        departemen: departemen ?? _departemen,
        tglLog: tglLog ?? _tglLog,
        idLog: idLog ?? _idLog,
        statusLogIom: statusLogIom ?? _statusLogIom,
        nomor: nomor ?? _nomor,
        idIom: idIom ?? _idIom,
        username: username ?? _username,
      );

  String? get namaUser => _namaUser;

  String? get departemen => _departemen;

  String? get tglLog => _tglLog;

  String? get idLog => _idLog;

  String? get statusLogIom => _statusLogIom;

  String? get nomor => _nomor;

  String? get idIom => _idIom;

  String? get username => _username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['namaUser'] = _namaUser;
    map['departemen'] = _departemen;
    map['tgl_log'] = _tglLog;
    map['id_log'] = _idLog;
    map['status_log_iom'] = _statusLogIom;
    map['nomor'] = _nomor;
    map['id_iom'] = _idIom;
    map['username'] = _username;
    return map;
  }
}
