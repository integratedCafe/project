import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intergrate_cafe/screen/Intro/bottom_nav_screen.dart';
import 'package:intergrate_cafe/screen/Intro/signin_screen.dart';
import 'package:intergrate_cafe/util/api.dart';
import 'package:intergrate_cafe/util/color.dart';
import 'package:intergrate_cafe/util/storage.dart';

class IntroScreen extends StatefulWidget {
  @override
  _PasswordVisible createState() => _PasswordVisible();
}

class _PasswordVisible extends State<IntroScreen> {
  ApiService apiService = ApiService();
  bool _obscureText = true;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  DateTime? _lastPressedAt;

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (_lastPressedAt == null ||
        now.difference(_lastPressedAt!) > Duration(seconds: 2)) {
      _lastPressedAt = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('뒤로 가기 버튼을 한 번 더 클릭하면 종료됩니다.'),
          duration: Duration(seconds: 2),
        ),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.flutter_dash,
                size: 150,
                color: ColorH.main(),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: '아이디를 입력해주세요',
                    hintStyle: TextStyle(color: Color(0xFFB0B0B0)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: ColorH.main(),
                        width: 2.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  maxLength: 30,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: '비밀번호를 입력해주세요',
                    hintStyle: TextStyle(color: Color(0xFFB0B0B0)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: ColorH.main(),
                        width: 2.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  obscureText: _obscureText,
                  maxLength: 20,
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await login(context);

                      } catch (e) {
                        String message ="기타 오류가 발생했습니다.";

                        // 로그인 실패 시 SnackBar로 메시지 표시
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: Text('로그인',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorH.main(),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("회원가입 클릭됨");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                      );
                    },
                    child: Text(
                      '회원가입',
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorH.main(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text('|', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      print("비밀번호 찾기 클릭됨");
                    },
                    child: Text(
                      '비밀번호 찾기',
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorH.main(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> login(BuildContext context) async {
    String endpoint = '/user/login';
    Map<String, dynamic> data = {
      "phone": phoneController.text,
      "password": passwordController.text,
    };

    Map<String, dynamic> result = await apiService.post(endpoint, data);
    print(result['success']);
    if (result['success'] == false) {
      String message = result['msg'] ?? "오류가 발생했습니다.";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      saveLoginData(result);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavScreen(),
        ),
      );
    }

    return result;
  }


  Future<void> saveLoginData(Map<String, dynamic> result) async {
    SecureStorageHelper storageHelper = SecureStorageHelper();
    await storageHelper.set('success', result['success']);
    await storageHelper.set('token', result['token']);

    Map<String, dynamic> user = result['user'];
    await storageHelper.set('userId', user['_id']);
    await storageHelper.set('nickname', user['nickname']);
    await storageHelper.set('email', user['email']);
    await storageHelper.set('phone', user['phone']);
    await storageHelper.set('loginWay', user['loginWay']);
    await storageHelper.set('marketing', user['marketing'].toString());
    await storageHelper.set('appPush', user['appPush'].toString());
    await storageHelper.set('locAgreement', user['locAgreement'].toString());
    await storageHelper.set('isOwner', user['isOwner'].toString());

  }

}
