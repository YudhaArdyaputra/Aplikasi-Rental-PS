import 'package:flutter/material.dart';
import 'package:rental_ps/Screen/Start_Screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              'Putu Devandra Radiastu Putra',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Jalan Pulau Serangan No. 29 Singaraja',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 10),
            Text(
              '082359177036',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            Text(
              'Additional Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text('Email'),
                    subtitle: Text('putudevanradiastu@gmail.com'),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Location'),
                    subtitle: Text('Singaraja, Bali, Indonesia'),
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('Date of Birth'),
                    subtitle: Text('November 30, 2003'),
                  ),
                  ListTile(
                    leading: Icon(Icons.school),
                    title: Text('Education'),
                    subtitle: Text('Fakultas Teknik dan Kejuruan Undiksha'),
                  ),
                  ListTile(
                    leading: Icon(Icons.work),
                    title: Text('Work'),
                    subtitle: Text('Software Engineer at Dave Company'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StartScreen()),
                );
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
