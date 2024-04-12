import 'package:flutter/material.dart';
import 'package:rental_ps/Screen/Pemesanan.dart';
import 'package:rental_ps/Screen/addtypes.dart';
import 'package:rental_ps/Screen/profile.dart';
import 'package:rental_ps/Screen/riwayat.dart';
import 'package:rental_ps/mahasiswa/mahasiswa/mahasiswa_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // set initial screen index here

  final List<Widget> _screens = [
    const PemesananScreen(),
    const RiwayatScreen(),
    const ProfileScreen(),
  ];

  final List<String> _appBarTitles = const [
    "Pemesanan",
    "",
    "Profile",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
      ),
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 3, 108, 255),
          ),
          child: Text('Dave PlayStation'),
        ),
        ListTile(
          title: const Text('Latihan CRUD SQLITE'),
          selected: _selectedIndex == 0,
          onTap: () {
            _onItemTapped(0);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTypes()),
            );
          },
        ),
        ListTile(
          title: const Text('Latihan API'),
          selected: _selectedIndex == 0,
          onTap: () {
            _onItemTapped(0);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MahasiswaScreen()),
            );
          },
        ),
        ListTile(
          title: const Text('Home'),
          selected: _selectedIndex == 0,
          onTap: () {
            // Update the state of the app
            _onItemTapped(0);
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('History'),
          selected: _selectedIndex == 1,
          onTap: () {
            // Update the state of the app
            _onItemTapped(1);
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Profile'),
          selected: _selectedIndex == 2,
          onTap: () {
            // Update the state of the app
            _onItemTapped(2);
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
      ])),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Pemesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              color: Colors.black,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 62, 139, 255),
        onTap: _onItemTapped, // add onTap callback
      ),
    );
  }
}
