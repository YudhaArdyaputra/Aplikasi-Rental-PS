import 'package:flutter/material.dart';
import 'package:rental_ps/Screen/Start_Screen_new.dart';

class ProfileRentalPS extends StatefulWidget {
  const ProfileRentalPS({super.key});

  @override
  ProfileRentalPSState createState() => ProfileRentalPSState();
}

class ProfileRentalPSState extends State<ProfileRentalPS> {
  final String imageUrl = 'assets/images/GPS.png'; // Ganti dengan path gambar yang diinginkan
  final String rentalName = 'Garage PlayStation';
  final String ownerName = 'IB Resta Parasara';
  final String address = 'Jalan Bisma No 14, Singaraja, Buleleng, Bali';
  final String phoneNumber = '087764471788';
  final String openingTime = '10:00';
  final String closingTime = '02:00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageCard(imageUrl),
              const SizedBox(height: 30),
              _buildInfoRow(Icons.store, 'Nama Rental PS', rentalName),
              _buildInfoRow(Icons.person, 'Nama Pemilik', ownerName),
              _buildInfoRow(Icons.location_on, 'Alamat', address),
              _buildInfoRow(Icons.phone, 'No HP', phoneNumber),
              _buildInfoRow(Icons.access_time, 'Jam Buka', openingTime),
              _buildInfoRow(Icons.access_time, 'Jam Tutup', closingTime),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const StartScreen()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  child: const Text('Log Out', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard(String imagePath) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 250,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.indigoAccent, size: 28),
          const SizedBox(width: 20),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                  TextSpan(text: value, style: const TextStyle(fontSize: 16, color: Colors.black87)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
