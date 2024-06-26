import 'package:flutter/material.dart';
import 'package:rental_ps/Screen/data_pelanggan.dart';
import 'package:rental_ps/Screen/profile_admin.dart';
import 'package:rental_ps/Screen/riwayat_admin.dart';
import 'package:rental_ps/Screen/start_screen_new.dart';

class HomeScreenAdmin extends StatefulWidget {
  const HomeScreenAdmin({super.key});

  @override
  State<HomeScreenAdmin> createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
  int _selectedIndex = 0; // set initial screen index here
  final String _userName = 'Admin GPS';
  final String _userEmail = 'GaragePS@gmail.com';

  final List<Widget> _screens = [
    const DataPelangganScreen(),
    const RiwayatAdminScreen(),
    const ProfileRentalPS(),
  ];

  final List<String> _appBarTitles = const [
    "Data Pelanggan",
    "Riwayat",
    "Profile RentalPS",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StartScreen()), // Navigate to StartScreen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appBarTitles[_selectedIndex],
          style: const TextStyle(color: Colors.black), // Set text color to black for visibility
        ),
        backgroundColor: Colors.white, // Set AppBar color to white
        iconTheme: const IconThemeData(color: Colors.black), // Set icon color to black
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_userName),
              accountEmail: Text(_userEmail),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  _userName[0], // Display first letter of user name
                  style: const TextStyle(fontSize: 40.0, color: Colors.deepPurple),
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Data Pelanggan'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Riwayat'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Profile RentalPS'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Data Pelanggan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped, // add onTap callback
      ),
    );
  }
}
