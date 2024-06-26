import 'package:flutter/material.dart';
import 'package:rental_ps/Screen/pemesanan_screen.dart';
import 'package:rental_ps/Screen/Start_Screen_new.dart';
import 'package:rental_ps/Screen/maps.dart';
import 'package:rental_ps/Screen/profile.dart';
import 'package:rental_ps/Screen/riwayat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_ps/cubit/auth/datalogin/cubit/data_login_cubit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // set initial screen index here
  String _userName = '';
  String _userPhone = '';

  final List<Widget> _screens = [
    const PemesananScreen(),
    const RiwayatScreen(),
    const ProfileScreen(),
  ];

  final List<String> _appBarTitles = const [
    "Pemesanan",
    "Riwayat screen",
    "Profile",
  ];

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final profile = context.read<DataLoginCubit>();
    final currentState = profile.state;

    int idUser = currentState.idUser;

    try {
      final response = await http.get(
        Uri.parse('http://172.20.10.2:5000/api/v1/user/read_by_user?id_user=$idUser'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _userName = data['datas'][0]['username'];
          _userPhone = data['datas'][0]['nohp'];
        });
      } else {
        setState(() {
          _userName = 'Failed to load data';
          _userPhone = '';
        });
      }
    } catch (e) {
      setState(() {
        _userName = 'An error occurred';
        _userPhone = '';
      });
    }
  }

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
        title: Text(_appBarTitles[_selectedIndex]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_userName),
              accountEmail: Text(_userPhone),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  _userName.isNotEmpty ? _userName[0] : 'U', // Display first letter of user name
                  style: const TextStyle(fontSize: 40.0, color: Colors.blue),
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.indigoAccent,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
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
              leading: const Icon(Icons.history),
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
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('maps'),
              selected: _selectedIndex == 2,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Maps(),
                    ),
                  );
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
            icon: Icon(Icons.home),
            label: 'Pemesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 62, 139, 255),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped, // add onTap callback
      ),
    );
  }
}
