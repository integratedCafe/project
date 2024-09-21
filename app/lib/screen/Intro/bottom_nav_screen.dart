import 'package:flutter/material.dart';
import 'package:intergrate_cafe/screen/home/home_screen.dart';
import 'package:intergrate_cafe/util/color.dart';
import 'package:intergrate_cafe/widget/fnb.dart';
import 'package:intergrate_cafe/widget/gnb.dart';


class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    Center(child: HomeScreen()),
    Center(child: Text('Cafe List Screen')),
    Center(child: Text('Order History Screen')),
    Center(child: Text('Settings Screen')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void navigateToHome(BuildContext context) {
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorH.main(),
        elevation: 0,
        title: Builder(builder: (context) {
          return Gnb(onNavigateHome: () => navigateToHome(context));
        }),
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: Fnb(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
