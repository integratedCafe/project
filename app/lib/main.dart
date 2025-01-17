import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

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
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  //   // options: FirebaseOptions(apiKey: apiKey, appId: appId, messagingSenderId: messagingSenderId, projectId: projectId)
  // );

  // FCM 토큰 가져오기
  String? fcmToken = await FCMService.initializeAndGetToken();
  final token = await FirebaseMessaging.instance.getAPNSToken();
  print("Get TOk: $token");
  if (fcmToken != null) {
    print('FCM 토큰: $fcmToken');
  }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caffeine Dev',
      theme: ThemeData(brightness: Brightness.light),
      home: Scaffold(
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
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Intro Screen',
  //     home: IntroScreen(),
  //   );
// }
}
