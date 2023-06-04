/// no_kasbon : "BON/GC/00001"
/// username : "farah"
/// departemen : "HC & LEGAL DIVISION"
/// tgl : "2022-06-07 07:56:41"
/// namaUser : "Bachtiar Brian"
/// approve : "obet"
/// status_approve : "Dibuat Oleh"
/// komen : "test"
/// status : "C"

class KasbonCommentDto {
  KasbonCommentDto({
    String? noKasbon,
    String? username,
    String? departemen,
    String? tgl,
    String? namaUser,
    String? approve,
    String? statusApprove,
    String? komen,
    String? status,
  }) {
    _noKasbon = noKasbon;
    _username = username;
    _departemen = departemen;
    _tgl = tgl;
    _namaUser = namaUser;
    _approve = approve;
    _statusApprove = statusApprove;
    _komen = komen;
    _status = status;
  }

  KasbonCommentDto.fromJson(dynamic json) {
    _noKasbon = json['no_kasbon'];
    _username = json['username'];
    _departemen = json['departemen'];
    _tgl = json['tgl'];
    _namaUser = json['namaUser'];
    _approve = json['approve'];
    _statusApprove = json['status_approve'];
    _komen = json['komen'];
    _status = json['status'];
  }

  String? _noKasbon;
  String? _username;
  String? _departemen;
  String? _tgl;
  String? _namaUser;
  String? _approve;
  String? _statusApprove;
  String? _komen;
  String? _status;

  KasbonCommentDto copyWith({
    String? noKasbon,
    String? username,
    String? departemen,
    String? tgl,
    String? namaUser,
    String? approve,
    String? statusApprove,
    String? komen,
    String? status,
  }) =>
      KasbonCommentDto(
        noKasbon: noKasbon ?? _noKasbon,
        username: username ?? _username,
        departemen: departemen ?? _departemen,
        tgl: tgl ?? _tgl,
        namaUser: namaUser ?? _namaUser,
        approve: approve ?? _approve,
        statusApprove: statusApprove ?? _statusApprove,
        komen: komen ?? _komen,
        status: status ?? _status,
      );

  String? get noKasbon => _noKasbon;

  String? get username => _username;

  String? get departemen => _departemen;

  String? get tgl => _tgl;

  String? get namaUser => _namaUser;

  String? get approve => _approve;

  String? get statusApprove => _statusApprove;

  String? get komen => _komen;

  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['no_kasbon'] = _noKasbon;
    map['username'] = _username;
    map['departemen'] = _departemen;
    map['tgl'] = _tgl;
    map['namaUser'] = _namaUser;
    map['approve'] = _approve;
    map['status_approve'] = _statusApprove;
    map['komen'] = _komen;
    map['status'] = _status;
    return map;
  }
}
