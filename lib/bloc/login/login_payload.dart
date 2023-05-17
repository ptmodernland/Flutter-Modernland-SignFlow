class LoginPayload {
  final String username;
  final String password;
  final String token;
  final String address;
  final String ip;
  final String brand;
  final String model;
  final String phonetype;
  final String proses;

  LoginPayload({
    this.username = '',
    this.password = '',
    this.token = 'your_refreshed_token',
    this.address = '123 Main Street',
    this.ip = '192.168.0.1',
    this.brand = 'Samsung',
    this.model = 'Galaxy S21',
    this.phonetype = 'smartphone',
    this.proses = 'cek_login',
  });

}