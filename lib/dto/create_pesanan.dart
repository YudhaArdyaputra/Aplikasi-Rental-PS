class CreatePesananDto {
  final int idUser;
  final String tanggalSewa;
  final String tanggalKembali;
  final String jenisPs;
  final String jumlahStik;
  final int hargaPerHari;
  final double totalHarga;

  CreatePesananDto({
    required this.idUser,
    required this.tanggalSewa,
    required this.tanggalKembali,
    required this.jenisPs,
    required this.jumlahStik,
    required this.hargaPerHari,
    required this.totalHarga,
  });

  Map<String, dynamic> toJson() => {
        'id_user': idUser.toString(),
        'tanggal_sewa': tanggalSewa,
        'tanggal_kembali': tanggalKembali,
        'jenis_ps': jenisPs,
        'jumlah_stik': jumlahStik,
        'harga_per_hari': hargaPerHari.toString(),
        'total_harga': totalHarga.toString(),
      };
}
