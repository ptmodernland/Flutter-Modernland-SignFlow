/// id_detail : "100"
/// nomor : "001/XI/2020"
/// departemen : "-"
/// tgl : "2020-11-19 00:00:00"
/// namaUser : "jovi"
/// approve : "jovi"
/// status_approve : "Dibuat Oleh"
/// komen : "salah nama"
/// status : "C"

class IomCommentDto {
  IomCommentDto({
    String? idDetail,
    String? nomor,
    String? departemen,
    String? tgl,
    String? namaUser,
    String? approve,
    String? statusApprove,
    String? komen,
    String? status,
  }) {
    _idDetail = idDetail;
    _nomor = nomor;
    _departemen = departemen;
    _tgl = tgl;
    _namaUser = namaUser;
    _approve = approve;
    _statusApprove = statusApprove;
    _komen = komen;
    _status = status;
  }

  IomCommentDto.fromJson(dynamic json) {
    _idDetail = json['id_detail'];
    _nomor = json['nomor'];
    _departemen = json['departemen'];
    _tgl = json['tgl'];
    _namaUser = json['namaUser'];
    _approve = json['approve'];
    _statusApprove = json['status_approve'];
    _komen = json['komen'];
    _status = json['status'];
  }

  String? _idDetail;
  String? _nomor;
  String? _departemen;
  String? _tgl;
  String? _namaUser;
  String? _approve;
  String? _statusApprove;
  String? _komen;
  String? _status;

  IomCommentDto copyWith({
    String? idDetail,
    String? nomor,
    String? departemen,
    String? tgl,
    String? namaUser,
    String? approve,
    String? statusApprove,
    String? komen,
    String? status,
  }) =>
      IomCommentDto(
        idDetail: idDetail ?? _idDetail,
        nomor: nomor ?? _nomor,
        departemen: departemen ?? _departemen,
        tgl: tgl ?? _tgl,
        namaUser: namaUser ?? _namaUser,
        approve: approve ?? _approve,
        statusApprove: statusApprove ?? _statusApprove,
        komen: komen ?? _komen,
        status: status ?? _status,
      );

  String? get idDetail => _idDetail;

  String? get nomor => _nomor;

  String? get departemen => _departemen;

  String? get tgl => _tgl;

  String? get namaUser => _namaUser;

  String? get approve => _approve;

  String? get statusApprove => _statusApprove;

  String? get komen => _komen;

  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_detail'] = _idDetail;
    map['nomor'] = _nomor;
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
