/// nomor : "KM-MLR/ESTATE/2023/VI/029"
/// kepada : "Bp. David Iman Santosa"
/// namaUser : "Hanni Pratiwi"
/// departemen : "TOWN MANAGEMENT"
/// cc : "Bp. Yap. William"
/// dari : "Bp. Dendi Karmawan"
/// tanggal : "05-June-2023"
/// jenis : "IOM PEMBERITAHUAN"
/// perihal : "Pengajuan Biaya Perbaikan Pompa Sirkulasi Kolam Renang Cluster Costarica"
/// attch_lampiran : ""
/// approve : "dendi.karmawan"
/// status : "Y"
/// kordinasi : "T"
/// kategori_iom : "Pengajuan Biaya"

class IomDetailDto {
  IomDetailDto({
    String? nomor,
    String? kepada,
    String? namaUser,
    String? departemen,
    String? cc,
    String? dari,
    String? tanggal,
    String? jenis,
    String? perihal,
    String? attchLampiran,
    String? approve,
    String? status,
    String? kordinasi,
    String? kategoriIom,
  }) {
    _nomor = nomor;
    _kepada = kepada;
    _namaUser = namaUser;
    _departemen = departemen;
    _cc = cc;
    _dari = dari;
    _tanggal = tanggal;
    _jenis = jenis;
    _perihal = perihal;
    _attchLampiran = attchLampiran;
    _approve = approve;
    _status = status;
    _kordinasi = kordinasi;
    _kategoriIom = kategoriIom;
  }

  IomDetailDto.fromJson(dynamic json) {
    _nomor = json['nomor'];
    _kepada = json['kepada'];
    _namaUser = json['namaUser'];
    _departemen = json['departemen'];
    _cc = json['cc'];
    _dari = json['dari'];
    _tanggal = json['tanggal'];
    _jenis = json['jenis'];
    _perihal = json['perihal'];
    _attchLampiran = json['attch_lampiran'];
    _approve = json['approve'];
    _status = json['status'];
    _kordinasi = json['kordinasi'];
    _kategoriIom = json['kategori_iom'];
  }

  String? _nomor;
  String? _kepada;
  String? _namaUser;
  String? _departemen;
  String? _cc;
  String? _dari;
  String? _tanggal;
  String? _jenis;
  String? _perihal;
  String? _attchLampiran;
  String? _approve;
  String? _status;
  String? _kordinasi;
  String? _kategoriIom;

  IomDetailDto copyWith({
    String? nomor,
    String? kepada,
    String? namaUser,
    String? departemen,
    String? cc,
    String? dari,
    String? tanggal,
    String? jenis,
    String? perihal,
    String? attchLampiran,
    String? approve,
    String? status,
    String? kordinasi,
    String? kategoriIom,
  }) =>
      IomDetailDto(
        nomor: nomor ?? _nomor,
        kepada: kepada ?? _kepada,
        namaUser: namaUser ?? _namaUser,
        departemen: departemen ?? _departemen,
        cc: cc ?? _cc,
        dari: dari ?? _dari,
        tanggal: tanggal ?? _tanggal,
        jenis: jenis ?? _jenis,
        perihal: perihal ?? _perihal,
        attchLampiran: attchLampiran ?? _attchLampiran,
        approve: approve ?? _approve,
        status: status ?? _status,
        kordinasi: kordinasi ?? _kordinasi,
        kategoriIom: kategoriIom ?? _kategoriIom,
      );

  String? get nomor => _nomor;

  String? get kepada => _kepada;

  String? get namaUser => _namaUser;

  String? get departemen => _departemen;

  String? get cc => _cc;

  String? get dari => _dari;

  String? get tanggal => _tanggal;

  String? get jenis => _jenis;

  String? get perihal => _perihal;

  String? get attchLampiran => _attchLampiran;

  String? get approve => _approve;

  String? get status => _status;

  String? get kordinasi => _kordinasi;

  String? get kategoriIom => _kategoriIom;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nomor'] = _nomor;
    map['kepada'] = _kepada;
    map['namaUser'] = _namaUser;
    map['departemen'] = _departemen;
    map['cc'] = _cc;
    map['dari'] = _dari;
    map['tanggal'] = _tanggal;
    map['jenis'] = _jenis;
    map['perihal'] = _perihal;
    map['attch_lampiran'] = _attchLampiran;
    map['approve'] = _approve;
    map['status'] = _status;
    map['kordinasi'] = _kordinasi;
    map['kategori_iom'] = _kategoriIom;
    return map;
  }
}
