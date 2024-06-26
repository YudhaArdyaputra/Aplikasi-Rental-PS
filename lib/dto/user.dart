class UserDTO {
  final String username;
  final String password;
  final String roles;
  final String namaLengkap;
  final String alamat;
  final String nohp;
  

  UserDTO({
    required this.username,
    required this.password,
    this.roles = 'umum',
    required this.namaLengkap,
    required this.alamat,
    required this.nohp,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'roles': roles,
      'nama_lengkap': namaLengkap,
      'alamat': alamat,
      'nohp': nohp,
    };
  }
}
