/// id_kordinasi : "174"
/// id_iom : "4424"
/// untuk : "#Head-5253"
/// departemen : "IT"
/// tanggal : "08-June-2023"
/// nomor : "168CORSEC-001"
/// perihal : "Testing Perihal"
/// approve : "168junction"
/// status_kor : "T"
/// status_email : "T"
/// namaUser : "Head 168junction"
/// UserKordinasi : "#Head-5253"

class RekomendasiWaitingDto {
  RekomendasiWaitingDto({
    String? idKordinasi,
    String? idIom,
    String? untuk,
    String? departemen,
    String? tanggal,
    String? nomor,
    String? perihal,
    String? approve,
    String? statusKor,
    String? statusEmail,
    String? namaUser,
    String? userKordinasi,
  }) {
    _idKordinasi = idKordinasi;
    _idIom = idIom;
    _untuk = untuk;
    _departemen = departemen;
    _tanggal = tanggal;
    _nomor = nomor;
    _perihal = perihal;
    _approve = approve;
    _statusKor = statusKor;
    _statusEmail = statusEmail;
    _namaUser = namaUser;
    _userKordinasi = userKordinasi;
  }

  RekomendasiWaitingDto.fromJson(dynamic json) {
    _idKordinasi = json['id_kordinasi'];
    _idIom = json['id_iom'];
    _untuk = json['untuk'];
    _departemen = json['departemen'];
    _tanggal = json['tanggal'];
    _nomor = json['nomor'];
    _perihal = json['perihal'];
    _approve = json['approve'];
    _statusKor = json['status_kor'];
    _statusEmail = json['status_email'];
    _namaUser = json['namaUser'];
    _userKordinasi = json['UserKordinasi'];
  }

  String? _idKordinasi;
  String? _idIom;
  String? _untuk;
  String? _departemen;
  String? _tanggal;
  String? _nomor;
  String? _perihal;
  String? _approve;
  String? _statusKor;
  String? _statusEmail;
  String? _namaUser;
  String? _userKordinasi;

  RekomendasiWaitingDto copyWith({
    String? idKordinasi,
    String? idIom,
    String? untuk,
    String? departemen,
    String? tanggal,
    String? nomor,
    String? perihal,
    String? approve,
    String? statusKor,
    String? statusEmail,
    String? namaUser,
    String? userKordinasi,
  }) =>
      RekomendasiWaitingDto(
        idKordinasi: idKordinasi ?? _idKordinasi,
        idIom: idIom ?? _idIom,
        untuk: untuk ?? _untuk,
        departemen: departemen ?? _departemen,
        tanggal: tanggal ?? _tanggal,
        nomor: nomor ?? _nomor,
        perihal: perihal ?? _perihal,
        approve: approve ?? _approve,
        statusKor: statusKor ?? _statusKor,
        statusEmail: statusEmail ?? _statusEmail,
        namaUser: namaUser ?? _namaUser,
        userKordinasi: userKordinasi ?? _userKordinasi,
      );
  String? get idKordinasi => _idKordinasi;

  String? get idIom => _idIom;

  String? get untuk => _untuk;

  String? get departemen => _departemen;
  String? get tanggal => _tanggal;
  String? get nomor => _nomor;
  String? get perihal => _perihal;
  String? get approve => _approve;
  String? get statusKor => _statusKor;
  String? get statusEmail => _statusEmail;
  String? get namaUser => _namaUser;
  String? get userKordinasi => _userKordinasi;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_kordinasi'] = _idKordinasi;
    map['id_iom'] = _idIom;
    map['untuk'] = _untuk;
    map['departemen'] = _departemen;
    map['tanggal'] = _tanggal;
    map['nomor'] = _nomor;
    map['perihal'] = _perihal;
    map['approve'] = _approve;
    map['status_kor'] = _statusKor;
    map['status_email'] = _statusEmail;
    map['namaUser'] = _namaUser;
    map['UserKordinasi'] = _userKordinasi;
    return map;
  }
}