// ignore_for_file: file_names

import 'package:emergentesapp/ui/screens/ScreenAccount.dart';
import 'package:flutter/material.dart';

import '../ui/screens/ScreenHome.dart';
import '../ui/screens/ScreenListRegisters.dart';
import '../ui/screens/ScreenOptions.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    ScreenHome(),
    ScreenOptions(),
    ScreenRegisters(),
    ScreenAccount(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(0xFF343764),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Options',
            backgroundColor: Color(0xFF343764),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Registers',
            backgroundColor: Color(0xFF343764),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
            backgroundColor: Color(0xFF343764),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFebebf2),
        onTap: _onItemTapped,
      ),
    );
  }
}