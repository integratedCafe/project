import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intergrate_cafe/screen/Intro/intro_screen.dart';

// import Widget
import 'package:intergrate_cafe/widget/fnb.dart';
import 'package:intergrate_cafe/widget/gnb.dart';

// import Screen
import 'package:intergrate_cafe/screen/home/home_screen.dart';

// import Uitl
import 'package:intergrate_cafe/util/color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('Main Init!!');
  await dotenv.load(fileName: ".env");
  // dotenv.testLoad({'BASE_URL': 'localhost:8080'});
  print(dotenv.env['BASE_URL']); // 환경 변수가 제대로 로드되었는지 확인

  runApp(const MyApp());
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
    Center(child: Text('Cafe List Screen')),
    Center(child: Text('Order History Screen')),
    Center(child: Text('Settings Screen')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intro Screen',
      home: IntroScreen(),
    );
  }
}
