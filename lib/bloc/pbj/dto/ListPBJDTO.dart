/// no_permintaan : "PRGCC230105"
/// namaUser : "Ardi Zariat"
/// departemen : "IT"
/// jenis : "PERMOHONAN BARANG JASA"
/// status : "T"
/// approve : "obet"
/// tgl_permintaan : "27-October-1975"

class ListPbjdto {
  ListPbjdto({
    String? noPermintaan,
    String? namaUser,
    String? departemen,
    String? jenis,
    String? status,
    String? approve,
    String? tglPermintaan,
  }) {
    _noPermintaan = noPermintaan;
    _namaUser = namaUser;
    _departemen = departemen;
    _jenis = jenis;
    _status = status;
    _approve = approve;
    _tglPermintaan = tglPermintaan;
  }

  ListPbjdto.fromJson(dynamic json) {
    _noPermintaan = json['no_permintaan'];
    _namaUser = json['namaUser'];
    _departemen = json['departemen'];
    _jenis = json['jenis'];
    _status = json['status'];
    _approve = json['approve'];
    _tglPermintaan = json['tgl_permintaan'];
  }

  String? _noPermintaan;
  String? _namaUser;
  String? _departemen;
  String? _jenis;
  String? _status;
  String? _approve;
  String? _tglPermintaan;

  ListPbjdto copyWith({
    String? noPermintaan,
    String? namaUser,
    String? departemen,
    String? jenis,
    String? status,
    String? approve,
    String? tglPermintaan,
  }) =>
      ListPbjdto(
        noPermintaan: noPermintaan ?? _noPermintaan,
        namaUser: namaUser ?? _namaUser,
        departemen: departemen ?? _departemen,
        jenis: jenis ?? _jenis,
        status: status ?? _status,
        approve: approve ?? _approve,
        tglPermintaan: tglPermintaan ?? _tglPermintaan,
      );

  String? get noPermintaan => _noPermintaan;

  String? get namaUser => _namaUser;

  String? get departemen => _departemen;

  String? get jenis => _jenis;

  String? get status => _status;

  String? get approve => _approve;

  String? get tglPermintaan => _tglPermintaan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['no_permintaan'] = _noPermintaan;
    map['namaUser'] = _namaUser;
    map['departemen'] = _departemen;
    map['jenis'] = _jenis;
    map['status'] = _status;
    map['approve'] = _approve;
    map['tgl_permintaan'] = _tglPermintaan;
    return map;
  }
}
