import 'dart:math';

import 'package:flutter/material.dart';

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat'),
        automaticallyImplyLeading: false, // This line removes the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Replace this with your actual data length
                itemBuilder: (context, index) {
                  final random = Random();
                  final day = random.nextInt(30) + 1;
                  final month = random.nextInt(12) + 1;
                  final year = random.nextInt(1) + 2024;
                  final date = DateTime(year, month, day);
                  return _buildActivityItem(
                    icon: Icons.shopping_cart,
                    title: 'Pemesanan',
                    amount: '\$120',
                    date: '${_formatDate(date)}',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String amount,
    required String date,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.blue,
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'Amount: $amount',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 4),
              Text(
                'Date: $date',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
