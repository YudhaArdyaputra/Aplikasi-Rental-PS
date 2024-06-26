import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rental_ps/Screen/update_pesanan.dart';
import 'package:rental_ps/dto/pesanan.dart';
import 'package:rental_ps/services/data_service.dart';

class RiwayatAdminScreen extends StatefulWidget {
  const RiwayatAdminScreen({super.key});

  @override
  RiwayatAdminScreenState createState() => RiwayatAdminScreenState();
}

class RiwayatAdminScreenState extends State<RiwayatAdminScreen> {
  List<Pesanan> pesananList = [];
  List<Pesanan> filteredPesananList = [];
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  bool isAscending = true;

  @override
  void initState() {
    super.initState();
    fetchPesanan();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
        filterPesananList();
      });
    });
  }

  Future<void> fetchPesanan() async {
    final dataService = DataService();
    pesananList = await dataService.fetchPesanan(orderBy: isAscending ? 'ASC' : 'DESC');
    setState(() {
      filteredPesananList = pesananList;
    });
  }

  void filterPesananList() {
    setState(() {
      filteredPesananList = pesananList.where((pesanan) {
        final pesananId = pesanan.idPesanan.toString().toLowerCase();
        final userId = pesanan.idUser.toString().toLowerCase();
        final jenisPs = pesanan.jenisPs.toLowerCase();
        final query = searchQuery.toLowerCase();
        return pesananId.contains(query) || userId.contains(query) || jenisPs.contains(query);
      }).toList();
    });
  }

  String formatDateString(String dateString) {
    try {
      final dateTime = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'").parse(dateString);
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } catch (e) {
      return dateString;
    }
  }

  Future<void> deletePesanan(int idPesanan) async {
    final dataService = DataService();
    await dataService.deletePesanan(idPesanan);
    setState(() {
      pesananList.removeWhere((item) => item.idPesanan == idPesanan);
      filterPesananList();
    });

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sukses'),
          content: const Text('Pesanan berhasil dihapus.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> confirmDeletePesanan(int idPesanan) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin menghapus pesanan ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deletePesanan(idPesanan);
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  Future<void> updatePesanan(Pesanan pesanan) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdatePesananScreen(pesanan: pesanan)),
    );
    if (result == true) {
      fetchPesanan();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Cari...',
                        hintStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.search, color: Colors.black),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: Icon(isAscending ? Icons.arrow_downward : Icons.arrow_upward),
                    onPressed: () {
                      setState(() {
                        isAscending = !isAscending;
                        fetchPesanan();
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredPesananList.length,
                itemBuilder: (context, index) {
                  final pesanan = filteredPesananList[index];
                  return Card(
                    color: Colors.indigoAccent,
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pesanan ID: ${pesanan.idPesanan}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Divider(color: Colors.white.withOpacity(0.5)),
                          const SizedBox(height: 5),
                          Text(
                            'ID User: ${pesanan.idUser}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Jenis PS: ${pesanan.jenisPs}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Jumlah Stik: ${pesanan.jumlahStik}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Tanggal Sewa: ${formatDateString(pesanan.tanggalSewa)}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Tanggal Kembali: ${formatDateString(pesanan.tanggalKembali)}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Total Harga: Rp ${NumberFormat('#,###', 'id_ID').format(pesanan.totalHarga)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  updatePesanan(pesanan);
                                },
                                icon: const Icon(Icons.edit),
                                color: Colors.white,
                              ),
                              IconButton(
                                onPressed: () {
                                  confirmDeletePesanan(pesanan.idPesanan);
                                },
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
