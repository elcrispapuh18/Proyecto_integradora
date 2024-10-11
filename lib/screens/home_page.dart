import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:prueba_integradora/screens/home_screen.dart';
import 'package:prueba_integradora/screens/profile_screen.dart';
import 'package:prueba_integradora/screens/registros_screen.dart';
import 'package:prueba_integradora/screens/toros_screen.dart';
import 'package:prueba_integradora/screens/vacas_screen.dart';

class Home extends StatefulWidget {
  void cerrarsesion(){
    FirebaseAuth.instance.signOut();
  }
  const Home({super.key});

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
    int indexTap = 0;

int _selectedIndex = 0;
static final List<Widget> _screens = [
    HomeScreen(),
    RegistrosScreen(),
    VacasScreen(),
    TorosScreen(),
    ProfileScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: IndexedStack(
      index: _selectedIndex,
      children: _screens,
    ),
    bottomNavigationBar: BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavBarItem(CupertinoIcons.home, 'Inicio', 0),
          buildNavBarItem(CupertinoIcons.list_bullet, 'Registros', 1),
          buildNavBarItem(CupertinoIcons.doc, 'Vacas', 2),
          buildNavBarItem(CupertinoIcons.doc, 'Toros', 3),
          buildNavBarItem(CupertinoIcons.profile_circled, 'Profile', 4),
        ],
      ),
    ),
  );
}

  Widget buildNavBarItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index
                ? const Color.fromARGB(191,101,57,1)
                : Color.fromARGB(221, 0, 0, 0),
          ),
          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index
                  ? const Color.fromARGB(191,101,57,1)
                  : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
