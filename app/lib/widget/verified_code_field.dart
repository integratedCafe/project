import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intergrate_cafe/util/color.dart';

class VerificationCodeField extends StatefulWidget {
  final void Function(String) onCodeSent;

  VerificationCodeField({required this.onCodeSent});
  @override
  _VerificationCodeFieldState createState() => _VerificationCodeFieldState();
}

class _VerificationCodeFieldState extends State<VerificationCodeField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.clear();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendVerificationCode() {
    final code = _controller.text;
    String response;
    Future.delayed(Duration(seconds: 1), () {
      if (code.length == 6) {
        response = '200';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('인증번호 확인 완료'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        widget.onCodeSent(response);
      } else {
        response = '400';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('인증번호를 올바르게 입력하세요'),
            backgroundColor: ColorH.active(),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _controller,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    decoration: InputDecoration(
                      hintText: '인증번호를 입력해주세요',
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
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: ColorH.main(),
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
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: ElevatedButton(
              onPressed: _sendVerificationCode,
              child: Text('인증번호 확인',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorH.active(),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(double.infinity, 56),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
