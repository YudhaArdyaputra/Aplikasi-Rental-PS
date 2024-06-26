import 'package:flutter/material.dart';
import 'package:rental_ps/Screen/pemesanandetail_screen.dart';

class PemesananScreen extends StatefulWidget {
  const PemesananScreen({super.key});

  @override
  PemesananScreenState createState() => PemesananScreenState();
}

class PemesananScreenState extends State<PemesananScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            children: [
              _buildPemesananCard(
                title: "Garage PlayStation",
                image: "assets/images/GPS.png",
              ),
              
              const SizedBox(height: 10),
              
              _buildInfoSection(
                address: "Jalan Bisma No. 14 - Singaraja, Buleleng, Bali",
                owner: "IB Resta Parasara",
                phone: "087764471788",
                openHour: "10:00",
                closeHour: "02:00",
              ),
              
              const SizedBox(height: 10),
              
              ElevatedButton(
                onPressed: () {
                  _navigateToPemesananDetail(context, "Garage PlayStation");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigoAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Pesan Sekarang",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPemesananCard({
    required String title,
    required String image,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.indigoAccent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 32, // Perbesar ukuran teks
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Divider(
            color: Colors.white,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              image,
              width: double.infinity,
              height: 250, // Sesuaikan ukuran container gambar
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "TERSEDIA PILIHAN PS4 DAN PS 5 DENGAN GAME TERLENGKAP DAN TERUPDATE",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection({
    required String address,
    required String owner,
    required String phone,
    required String openHour,
    required String closeHour,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(Icons.location_on, address),
        _buildInfoRow(Icons.person, owner),
        _buildInfoRow(Icons.phone, phone),
        _buildInfoRow(Icons.access_time, "Jam Buka: $openHour"),
        _buildInfoRow(Icons.access_time, "Jam Tutup: $closeHour"),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.indigoAccent, size: 30),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToPemesananDetail(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PemesananDetailScreen(),
      ),
    );
  }
}
