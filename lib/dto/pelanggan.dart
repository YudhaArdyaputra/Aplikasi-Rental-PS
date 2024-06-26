class Pelanggan {
  final String idPelanggan;
  final String idUser;
  final String nama;
  final String alamat;
  final String noHp;

  Pelanggan({
    required this.idPelanggan,
    required this.idUser,
    required this.nama,
    required this.alamat,
    required this.noHp,
  });

  factory Pelanggan.fromJson(Map<String, dynamic> json) {
    return Pelanggan(
      idPelanggan: json['id_pelanggan'].toString(),
      idUser: json['id_user'].toString(),
      nama: json['nama'],
      alamat: json['alamat'],
      noHp: json['nohp'],
    );
  }
}
