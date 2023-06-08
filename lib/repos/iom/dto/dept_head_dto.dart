/// username : "5253"
/// namaUser : "#Head-5253"
/// departemen : "Komisaris"
/// email : "5253@gmail.com"

class DeptHeadDto {
  DeptHeadDto({
    String? username,
    String? namaUser,
    String? departemen,
    String? email,
  }) {
    _username = username;
    _namaUser = namaUser;
    _departemen = departemen;
    _email = email;
  }

  DeptHeadDto.fromJson(dynamic json) {
    _username = json['username'];
    _namaUser = json['namaUser'];
    _departemen = json['departemen'];
    _email = json['email'];
  }

  String? _username;
  String? _namaUser;
  String? _departemen;
  String? _email;

  DeptHeadDto copyWith({
    String? username,
    String? namaUser,
    String? departemen,
    String? email,
  }) =>
      DeptHeadDto(
        username: username ?? _username,
        namaUser: namaUser ?? _namaUser,
        departemen: departemen ?? _departemen,
        email: email ?? _email,
      );

  String? get username => _username;

  String? get namaUser => _namaUser;

  String? get departemen => _departemen;

  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = _username;
    map['namaUser'] = _namaUser;
    map['departemen'] = _departemen;
    map['email'] = _email;
    return map;
  }
}
