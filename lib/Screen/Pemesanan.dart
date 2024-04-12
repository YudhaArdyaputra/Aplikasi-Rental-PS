import 'package:flutter/material.dart';
import 'package:rental_ps/Screen/riwayat.dart';

class PemesananScreen extends StatelessWidget {
  const PemesananScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: ListView(
          children: [
            _buildPemesananCard(
              title: "Rental PS Undiksha",
              image: "assets/images/game.png",
              address:
                  "Alamat Rental PS Undiksha: Jalan Tasbih gang KaliSari No.7 Singaraja",
              onTap: () {
                _navigateToPemesananDetail(context, "Rental PS Undiksha");
              },
            ),
            SizedBox(height: 30),
            _buildPemesananCard(
              title: "Rental PS Penarukan",
              image: "assets/images/Skill.png",
              address:
                  "Alamat Rental PS Penarukan: Jalan Pulau Serangan No.29 Singaraja",
              onTap: () {
                _navigateToPemesananDetail(context, "Rental PS Penarukan");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPemesananCard({
    required String title,
    required String image,
    required String address,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 121, 146, 253),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 26),
            ),
            SizedBox(height: 10),
            Image.asset(image, width: 200, height: 200),
            SizedBox(height: 10),
            Text(
              address,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPemesananDetail(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PemesananDetailScreen(title: title),
      ),
    );
  }
}

class PemesananDetailScreen extends StatelessWidget {
  final String title;

  const PemesananDetailScreen({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: PemesananForm(),
      ),
    );
  }
}

class PemesananForm extends StatefulWidget {
  @override
  _PemesananFormState createState() => _PemesananFormState();
}

class _PemesananFormState extends State<PemesananForm> {
  late DateTime _selectedDate;
  late String _selectedPS;
  late int _selectedStik;
  late int _selectedDuration;
  late DurationType _selectedDurationType;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedPS = 'PS4';
    _selectedStik = 1;
    _selectedDuration = 1;
    _selectedDurationType = DurationType.hours;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tanggal Pemesanan:',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        TextButton(
          onPressed: () => _selectDate(context),
          child: Text(
            '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Jenis PS:',
          style: TextStyle(fontSize: 16),
        ),
        DropdownButton<String>(
          value: _selectedPS,
          onChanged: (String? newValue) {
            setState(() {
              _selectedPS = newValue!;
            });
          },
          items: <String>['PS4', 'PS5', 'Xbox', 'Nintendo Switch']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        Text(
          'Jumlah Stik PS:',
          style: TextStyle(fontSize: 16),
        ),
        Slider(
          value: _selectedStik.toDouble(),
          min: 1,
          max: 4,
          divisions: 3,
          label: _selectedStik.toString(),
          onChanged: (double value) {
            setState(() {
              _selectedStik = value.toInt();
            });
          },
        ),
        SizedBox(height: 20),
        Text(
          'Durasi Pemesanan:',
          style: TextStyle(fontSize: 16),
        ),
        Row(
          children: [
            Radio<DurationType>(
              value: DurationType.hours,
              groupValue: _selectedDurationType,
              onChanged: (DurationType? value) {
                setState(() {
                  _selectedDurationType = value!;
                });
              },
            ),
            Text('Jam'),
            SizedBox(width: 20),
            Radio<DurationType>(
              value: DurationType.days,
              groupValue: _selectedDurationType,
              onChanged: (DurationType? value) {
                setState(() {
                  _selectedDurationType = value!;
                });
              },
            ),
            Text('Hari'),
          ],
        ),
        Slider(
          value: _selectedDuration.toDouble(),
          min: 1,
          max: _selectedDurationType == DurationType.hours ? 24 : 7,
          divisions: _selectedDurationType == DurationType.hours ? 23 : 6,
          label: _selectedDurationType == DurationType.hours
              ? '${_selectedDuration.toInt()} Jam'
              : '${_selectedDuration.toInt()} Hari',
          onChanged: (double value) {
            setState(() {
              _selectedDuration = value.toInt();
            });
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RiwayatScreen()),
            );
          },
          child: Text('Pesan Sekarang'),
        ),
      ],
    );
  }
}

enum DurationType { hours, days }
