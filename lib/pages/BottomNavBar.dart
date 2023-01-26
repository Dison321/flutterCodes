import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Object _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    _selectedIndex = ModalRoute.of(context)?.settings.arguments ?? 0;
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        // BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        // BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_pin_outlined), label: 'Me'),
      ],
      currentIndex: int.parse(_selectedIndex.toString()),
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
        if (index == 0) {
          print("1");
          Navigator.pushReplacementNamed(context, '/homePage', arguments: 0);
        } else if (index == 1) {
          print("2");
        } else if (index == 2) {
          print("3");
          Navigator.pushNamed(context, '/resetPass');
        } else if (index == 3) {
          print("4");

          Navigator.pushReplacementNamed(context, '/profile', arguments: 3);
        }
      },
    );
  }
}
