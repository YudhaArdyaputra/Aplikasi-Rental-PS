import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_ps/cubit/auth/datalogin/cubit/data_login_cubit.dart';
import 'package:rental_ps/dto/pesanan.dart';
import 'package:rental_ps/services/data_service.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  RiwayatScreenState createState() => RiwayatScreenState();
}

class RiwayatScreenState extends State<RiwayatScreen> {
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
    final profile = context.read<DataLoginCubit>();
    final currentState = profile.state;
    int idUser = currentState.idUser;

    final dataService = DataService();
    pesananList = await dataService.fetchPesananByUser(idUser, orderBy: isAscending ? 'ASC' : 'DESC');
    setState(() {
      filteredPesananList = pesananList;
    });
  }

  void filterPesananList() {
    setState(() {
      filteredPesananList = pesananList.where((pesanan) {
        final pesananId = pesanan.idPesanan.toString().toLowerCase();
        final jenisPs = pesanan.jenisPs.toLowerCase();
        final query = searchQuery.toLowerCase();
        return pesananId.contains(query) || jenisPs.contains(query);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10.0),
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
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
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
