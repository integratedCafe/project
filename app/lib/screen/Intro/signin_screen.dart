import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intergrate_cafe/provider/user/signin_data.dart';
import 'package:intergrate_cafe/screen/Intro/intro_screen.dart';
import 'package:intergrate_cafe/util/api.dart';
import 'package:intergrate_cafe/util/color.dart';
import 'package:intergrate_cafe/widget/custom_appbar.dart';
import 'package:intergrate_cafe/widget/custom_dialog.dart';
import 'package:intergrate_cafe/widget/custom_dotted_divider.dart';
import 'package:intergrate_cafe/widget/verified_code_field.dart';

import '../Intro/bottom_nav_screen.dart';

class SignInScreen extends ConsumerWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInState = ref.watch(signInProvider);
    final passwordConfirmController =
        ref.watch(passwordConfirmControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: '회원가입',
        backgroundColor: ColorH.active(),
        borderColor: ColorH.active(),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flutter_dash,
              size: 100,
              color: ColorH.active(),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "전화번호",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          hintText: '전화번호를 입력해주세요',
                          hintStyle: TextStyle(color: Color(0xFFB0B0B0)),
                          filled: true,
                          fillColor: signInState.isPhoneVerified
                              ? Colors.grey[300]
                              : Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: ColorH.active(),
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: ColorH.active(),
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15.0),
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        maxLength: 11,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        enabled: !signInState.isPhoneVerified,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: signInState.isPhoneVerified
                            ? null
                            : () {
                                ref
                                    .read(signInProvider.notifier)
                                    .startPhoneVerification(
                                        phoneController.text);
                              },
                        child: FittedBox(
                          child: AutoSizeText(
                            '인증번호 발송',
                            style: TextStyle(color: Colors.white),
                            maxLines: 1,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorH.active(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fixedSize: Size.fromHeight(48),
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "인증번호",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 10),
            VerificationCodeField(onCodeSent: (code) {
              ref.read(signInProvider.notifier).verifyCode(code);
            }),
            if (signInState.isPhoneVerified) ...[
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: DottedLine(
                    height: 2.0,
                    color: Colors.black,
                    dashWidth: 4.0,
                    dashSpace: 4.0,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "비밀번호",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '비밀번호를 입력해주세요',
                    hintStyle: TextStyle(color: Color(0xFFB0B0B0)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: ColorH.active(),
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: ColorH.active(),
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                  ),
                  onChanged: (value) {
                    ref.read(signInProvider.notifier).updatePassword(value);
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  maxLength: 30,
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "비밀번호 확인",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: passwordConfirmController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '비밀번호를 재입력해주세요',
                        hintStyle: TextStyle(color: Color(0xFFB0B0B0)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: ColorH.active(),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: ColorH.active(),
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                      ),
                      onChanged: (value) {
                        ref
                            .read(signInProvider.notifier)
                            .updatePasswordConfirm(value);
                      },
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      maxLength: 30,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    if (!signInState.isEqualed)
                      Container(
                        margin: EdgeInsets.only(top: 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "비밀번호가 일치하지 않습니다.",
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "닉네임(선택)",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: nicknameController,
                  decoration: InputDecoration(
                    hintText: '사용하실 닉네임을 입력해주세요',
                    hintStyle: TextStyle(color: Color(0xFFB0B0B0)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: ColorH.active(),
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: ColorH.active(),
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "이메일(선택)",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: '사용하실 이메일을 입력해주세요',
                    hintStyle: TextStyle(color: Color(0xFFB0B0B0)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: ColorH.active(),
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: ColorH.active(),
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
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
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool isConfirmed = await showAlertDialog(context);
                      if (isConfirmed) {
                        signUp(context, signInState);
                        print('회원가입 진행');
                      } else {
                        print('회원가입 취소');
                      }
                    },
                    child: Text('회원가입',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorH.active(),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> signUp(BuildContext context, SignInState signInState) async {
    ApiService apiService = ApiService();

    String endpoint = '/user/signup';
    if (signInState.isEqualed) {
      Map<String, dynamic> data = {
        "phone": phoneController.text,
        "password": signInState.password,
        "nickname": nicknameController.text,
        "email": emailController.text
      };

      Map<String, dynamic> result = await apiService.post(endpoint, data);
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
        print("success");
        String message = "회원가입이 성공하였습니다.";

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => IntroScreen()),
          (route) => false,
        );
      }
    } else {
      String message = "비밀번호를 재확인해주십시오.";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
