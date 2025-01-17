import 'package:flutter/material.dart';
Future<bool> showAlertDialog(BuildContext context) async {
  bool? result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(''),
        content: Text('해당 정보로 회원가입하시겠습니까?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('회원가입'),
          ),
          TextButton(
            onPressed: () {
              // 취소 후 false 반환
              Navigator.of(context).pop(false);
            },
            child: Text('취소'),
          ),
        ],
      );
    },
  );

  return result ?? false;
}

