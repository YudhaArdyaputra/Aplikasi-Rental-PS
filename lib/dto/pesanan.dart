class Pesanan {
  final int idPesanan;
  final int idUser;
  final String jenisPs;
  final int jumlahStik;
  final String tanggalSewa;
  final String tanggalKembali;
  final int totalHarga;

  Pesanan({
    required this.idPesanan,
    required this.idUser,
    required this.jenisPs,
    required this.jumlahStik,
    required this.tanggalSewa,
    required this.tanggalKembali,
    required this.totalHarga,
  });

  factory Pesanan.fromJson(Map<String, dynamic> json) {
    return Pesanan(
      idPesanan: json['id_pesanan'],
      idUser: json['id_user'],
      jenisPs: json['jenis_ps'],
      jumlahStik: int.parse(json['jumlah_stik']),  // Konversi ke int
      tanggalSewa: json['tanggal_sewa'],
      tanggalKembali: json['tanggal_kembali'],
      totalHarga: json['total_harga'],
    );
  }
}
