

class User {
  String idUser;
  String username;
  String nama;
  String level;
  String email;
  String jk;
  bool status;

  User({
    required this.idUser,
    required this.username,
    required this.nama,
    required this.level,
    required this.email,
    required this.jk,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['id_user'],
      username: json['username'],
      nama: json['nama'],
      level: json['level'],
      email: json['email'],
      jk: json['jk'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_user': idUser,
      'username': username,
      'nama': nama,
      'level': level,
      'email': email,
      'jk': jk,
      'status': status,
    };
  }
}
