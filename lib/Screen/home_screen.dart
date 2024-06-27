import 'package:flutter/material.dart';
import 'package:rental_ps/Screen/pemesanan_screen.dart';
import 'package:rental_ps/Screen/Start_Screen_new.dart';
import 'package:rental_ps/Screen/maps.dart';
import 'package:rental_ps/Screen/profile.dart';
import 'package:rental_ps/Screen/riwayat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_ps/cubit/auth/datalogin/cubit/data_login_cubit.dart';
import 'package:rental_ps/services/data_service.dart';
import 'package:rental_ps/dto/profile.dart';
import 'package:rental_ps/endpoints/endpoints.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // set initial screen index here
  Profile? userData;
  bool isLoading = true;
  String errorMessage = '';

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
    setState(() {
      isLoading = true;
    });

    final profile = context.read<DataLoginCubit>();
    final currentState = profile.state;
    int idUser = currentState.idUser;

    try {
      userData = await DataService.fetchUserData(idUser);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
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
              accountName: Text(userData?.username ?? 'Loading...'),
              accountEmail: Text(userData?.noHp ?? ''),
              currentAccountPicture: ClipOval(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : (userData?.foto != null
                        ? Image.network(
                            '${Endpoints.getUserPhoto}/${userData!.idUser}',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              );
                            },
                          )
                        : const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          )),
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
              title: const Text('Maps'),
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
