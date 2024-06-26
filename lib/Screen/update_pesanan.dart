import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:rental_ps/dto/pesanan.dart';
import 'package:rental_ps/endpoints/endpoints.dart';

class UpdatePesananScreen extends StatefulWidget {
  final Pesanan pesanan;

  const UpdatePesananScreen({super.key, required this.pesanan});

  @override
  UpdatePesananScreenState createState() => UpdatePesananScreenState();
}

class UpdatePesananScreenState extends State<UpdatePesananScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController idUserController;
  late TextEditingController tanggalSewaController;
  late TextEditingController tanggalKembaliController;
  String? jenisPs;
  String? jumlahStik;

  @override
  void initState() {
    super.initState();
    idUserController = TextEditingController(text: widget.pesanan.idUser.toString());
    tanggalSewaController = TextEditingController(text: widget.pesanan.tanggalSewa);
    tanggalKembaliController = TextEditingController(text: widget.pesanan.tanggalKembali);
    jenisPs = widget.pesanan.jenisPs;
    jumlahStik = widget.pesanan.jumlahStik.toString();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      var response = await http.put(
        Uri.parse('${Endpoints.baseURLLive}/api/v1/pesanan/update'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'id_pesanan': widget.pesanan.idPesanan,
          'id_user': idUserController.text,
          'tanggal_sewa': tanggalSewaController.text,
          'tanggal_kembali': tanggalKembaliController.text,
          'jenis_ps': jenisPs,
          'jumlah_stik': jumlahStik,
        }),
      );
      

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pemesanan berhasil diperbarui')),
        );
        // ignore: use_build_context_synchronously
        Navigator.pop(context, true);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memperbarui pemesanan')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Pemesanan'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: idUserController,
                decoration: const InputDecoration(
                  labelText: 'ID User',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigoAccent, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'ID User tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
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
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigoAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                child: const Text('Perbarui Pemesanan', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
