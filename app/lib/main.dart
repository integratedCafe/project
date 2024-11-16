import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intergrate_cafe/screen/Intro/intro_screen.dart';

// import Widget
import 'package:intergrate_cafe/widget/fnb.dart';
import 'package:intergrate_cafe/widget/gnb.dart';

// import Screen
import 'package:intergrate_cafe/screen/home/home_screen.dart';
import 'package:intergrate_cafe/screen/cafe/cafe_list.dart';

// import Uitl
import 'package:intergrate_cafe/util/color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    Center(child: HomeScreen()),
    Center(child: CafeList()),
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
  //
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Caffeine Dev',
  //     theme: ThemeData(brightness: Brightness.light),
  //     home: Scaffold(
  //       appBar: AppBar(
  //         backgroundColor: ColorH.main(),
  //         elevation: 0,
  //         title: Builder(builder: (context) {
  //           return Gnb(onNavigateHome: () => navigateToHome(context));
  //         }),
  //       ),
  //       body: _widgetOptions[_selectedIndex],
  //       bottomNavigationBar: Fnb(
  //         currentIndex: _selectedIndex,
  //         onTap: _onItemTapped,
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intro Screen',
      home: IntroScreen(),
    );
}
}
