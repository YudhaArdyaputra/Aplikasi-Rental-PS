import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rental_ps/cubit/auth/datalogin/cubit/data_login_cubit.dart';
import 'package:rental_ps/dto/create_pesanan.dart';
import 'package:rental_ps/services/data_service.dart';

class PemesananDetailScreen extends StatefulWidget {
  const PemesananDetailScreen({super.key});

  @override
  PemesananDetailScreenState createState() => PemesananDetailScreenState();
}

class PemesananDetailScreenState extends State<PemesananDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final DataService _dataService = DataService();

  TextEditingController tanggalSewaController = TextEditingController();
  TextEditingController tanggalKembaliController = TextEditingController();
  String? jenisPs;
  String? jumlahStik;
  double? totalHarga;
  int hargaPerHari = 0;

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final profile = context.read<DataLoginCubit>();
      final currentState = profile.state;
      final idUser = currentState.idUser;

      CreatePesananDto dto = CreatePesananDto(
        idUser: idUser,
        tanggalSewa: tanggalSewaController.text,
        tanggalKembali: tanggalKembaliController.text,
        jenisPs: jenisPs!,
        jumlahStik: jumlahStik!,
        hargaPerHari: hargaPerHari,
        totalHarga: totalHarga!,
      );

      bool isSuccess = await _dataService.createPesanan(dto);

      if (isSuccess) {
        _showSuccessDialog();
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal membuat pemesanan')),
        );
      }
    } else {
      _showIncompleteDataDialog();
    }
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
        _calculateTotalHarga();
      });
    }
  }

  void _calculateTotalHarga() {
    if (tanggalSewaController.text.isNotEmpty && tanggalKembaliController.text.isNotEmpty && jenisPs != null) {
      DateTime tanggalSewa = DateTime.parse(tanggalSewaController.text);
      DateTime tanggalKembali = DateTime.parse(tanggalKembaliController.text);
      int hariSewa = tanggalKembali.difference(tanggalSewa).inDays;

      if (hariSewa < 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tanggal Kembali harus setelah Tanggal Sewa')),
        );
        return;
      }

      hargaPerHari = jenisPs == 'PS4' ? 150000 : 250000;
      setState(() {
        totalHarga = hariSewa * hargaPerHari.toDouble();
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pemesanan Berhasil'),
          content: const Text('Pemesanan berhasil dibuat.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Close the form screen
              },
            ),
          ],
        );
      },
    );
  }

  void _showIncompleteDataDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Data Tidak Lengkap'),
          content: const Text('Silakan lengkapi semua data yang diperlukan.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Pemesanan'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: tanggalSewaController,
                decoration: InputDecoration(
                  labelText: 'Tanggal Sewa',
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigoAccent, width: 2.0),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.indigoAccent),
                    onPressed: () => _selectDate(context, tanggalSewaController),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tanggal Sewa tidak boleh kosong';
                  }
                  return null;
                },
                readOnly: true,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: tanggalKembaliController,
                decoration: InputDecoration(
                  labelText: 'Tanggal Kembali',
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigoAccent, width: 2.0),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.indigoAccent),
                    onPressed: () => _selectDate(context, tanggalKembaliController),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tanggal Kembali tidak boleh kosong';
                  }
                  return null;
                },
                readOnly: true,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: jenisPs,
                items: ['PS4', 'PS5'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    jenisPs = newValue;
                    _calculateTotalHarga();
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Jenis PS',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigoAccent, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Jenis PS tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: jumlahStik,
                items: ['1', '2', '3', '4'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    jumlahStik = newValue;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Jumlah Stik',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigoAccent, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Jumlah Stik tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              if (totalHarga != null)
                Text(
                  'Total Harga: Rp ${NumberFormat('#,###', 'id_ID').format(totalHarga)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigoAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  minimumSize: const Size(double.infinity, 50), // Memperbesar ukuran tombol
                ),
                child: const Text('Buat Pemesanan', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
