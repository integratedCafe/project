import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intergrate_cafe/util/color.dart';
import 'package:intergrate_cafe/util/storage.dart';
import 'package:intergrate_cafe/widget/custom_appbar.dart';
import 'package:intergrate_cafe/widget/home/home_user_info.dart';
import 'package:intergrate_cafe/widget/mypage/mypage_user_info.dart';

import '../Intro/bottom_nav_screen.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  late Map<String, String> userInfo;

  Future<Map<String, String>> _loadUserInfo() async {
    SecureStorageHelper storageHelper = SecureStorageHelper();

    String userId = await storageHelper.get('userId') ?? '';
    String nickname = await storageHelper.get('nickname') ?? '';
    print(userId);
    print(nickname);
    return {'userId': userId, 'nickname': nickname};
  }

  @override
  void initState() {
    super.initState();
    print("Init State!");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
        future: _loadUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Map<String, String> userInfo = snapshot.data!;
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft, // 왼쪽 정렬
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                          children: [
                            Text(
                              "안녕하세요, ${userInfo['nickname'] ?? '닉네임'}님",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            const Text(
                              '보유 포인트 1000 점',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    const MyPageUserInfo(),
                    const SizedBox(height: 30),
                    const HomeUserInfo(
                        // frequencyImages: frequencyImages,
                        // favoriteImages: favoriteImages,
                        ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          }
        });
  }
}
