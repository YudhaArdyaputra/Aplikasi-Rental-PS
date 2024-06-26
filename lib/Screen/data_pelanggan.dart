import 'package:flutter/material.dart';
import 'package:rental_ps/dto/pelanggan.dart';
import 'package:rental_ps/services/data_service.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class DataPelangganScreen extends StatefulWidget {
  const DataPelangganScreen({super.key});

  @override
  DataPelangganScreenState createState() => DataPelangganScreenState();
}

class DataPelangganScreenState extends State<DataPelangganScreen> {
  List<Pelanggan> pelangganData = [];
  final _idPelangganController = TextEditingController();
  final _idUserController = TextEditingController();
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _noHpController = TextEditingController();
  int? _selectedPelangganIndex;

  @override
  void initState() {
    super.initState();
    _loadPelanggan();
  }

  Future<void> _loadPelanggan() async {
    pelangganData = await DataService.getPelanggan();
    setState(() {});
  }

  Future<void> _addPelanggan() async {
    await DataService.addPelanggan(
      _idUserController.text,
      _namaController.text,
      _alamatController.text,
      _noHpController.text,
    );
    _loadPelanggan();
    _showPopup('Data pelanggan berhasil ditambahkan');
  }

  Future<void> _editPelanggan(int index) async {
    await DataService.editPelanggan(
      _idPelangganController.text,
      _idUserController.text,
      _namaController.text,
      _alamatController.text,
      _noHpController.text,
    );
    _loadPelanggan();
    _showPopup('Data pelanggan berhasil diperbarui');
  }

  Future<void> _deletePelanggan(int index) async {
    final id = pelangganData[index].idPelanggan;
    await DataService.deletePelanggan(id);
    _loadPelanggan();
    _showPopup('Data pelanggan berhasil dihapus');
  }

  void _showForm([Pelanggan? pelanggan, int? index]) {
    if (pelanggan != null) {
      _idPelangganController.text = pelanggan.idPelanggan;
      _idUserController.text = pelanggan.idUser;
      _namaController.text = pelanggan.nama;
      _alamatController.text = pelanggan.alamat;
      _noHpController.text = pelanggan.noHp;
      _selectedPelangganIndex = index;
    } else {
      _idPelangganController.clear();
      _idUserController.clear();
      _namaController.clear();
      _alamatController.clear();
      _noHpController.clear();
      _selectedPelangganIndex = null;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(pelanggan != null ? 'Edit Pelanggan' : 'Tambah Pelanggan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _idPelangganController,
              decoration: const InputDecoration(labelText: 'ID Pelanggan'),
              readOnly: pelanggan != null,
            ),
            TextField(
              controller: _idUserController,
              decoration: const InputDecoration(labelText: 'ID User'),
            ),
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _alamatController,
              decoration: const InputDecoration(labelText: 'Alamat'),
            ),
            TextField(
              controller: _noHpController,
              decoration: const InputDecoration(labelText: 'No. HP'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              if (_selectedPelangganIndex == null) {
                _addPelanggan();
              } else {
                _editPelanggan(_selectedPelangganIndex!);
              }
              Navigator.of(context).pop();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Apakah Anda yakin ingin menghapus data pelanggan ini?'),
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
              _deletePelanggan(index);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _showPopup(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Informasi'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _selectPelanggan(int index) {
    setState(() {
      _selectedPelangganIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: pelangganData.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    color: Colors.indigoAccent,
                    child: ListTile(
                      leading: const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                      title: Text(
                        pelangganData[index].nama,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alamat: ${pelangganData[index].alamat}',
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            'No. HP: ${pelangganData[index].noHp}',
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                      onTap: () => _selectPelanggan(index),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.indigo,
        overlayOpacity: 0.5,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: 'Tambah Pelanggan',
            onTap: () => _showForm(),
          ),
          SpeedDialChild(
            child: const Icon(Icons.edit),
            label: 'Edit Pelanggan',
            onTap: () {
              if (_selectedPelangganIndex != null) {
                _showForm(pelangganData[_selectedPelangganIndex!], _selectedPelangganIndex);
              } else {
                _showPopup('Pilih pelanggan yang ingin diedit');
              }
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.delete),
            label: 'Hapus Pelanggan',
            onTap: () {
              if (_selectedPelangganIndex != null) {
                _showDeleteConfirmation(_selectedPelangganIndex!);
              } else {
                _showPopup('Pilih pelanggan yang ingin dihapus');
              }
            },
          ),
        ],
      ),
    );
  }
}
