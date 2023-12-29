// ignore_for_file: file_names

import 'package:emergentesapp/presentation/screens/account/ScreenAccount.dart';
import 'package:emergentesapp/presentation/screens/home/ScreenHome.dart';
import 'package:emergentesapp/presentation/screens/listRegisters/ScreenListRegisters.dart';
import 'package:flutter/material.dart';


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
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Registers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: const Color(0xFF343764),
        selectedItemColor: const Color(0xFFebebf2),
        onTap: _onItemTapped,
      ),
    );
  }
}