import 'package:flutter/material.dart';
import 'package:watchdog/constants/colors.dart';
import 'package:watchdog/screens/map.dart';
import 'package:watchdog/screens/profile.dart';
import 'package:watchdog/screens/suspects.dart';
import 'package:watchdog/widgets/homepage.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedPage = 0;
  final List<Widget> _screens = [
    HomepageWidget(),
    OSMMap(),
    WantedSuspects(),
    ProfileScreen(),
  ];
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: _screens[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: 'Map',
            tooltip: 'View reported incidents on a map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin_outlined),
            label: 'Suspects',
            tooltip: 'View wanted suspects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
            tooltip: 'Your profile',
          ),
        ],
      ),
    );
  }
}
