import 'package:flutter/material.dart';

const preHexCode = '0xFF';

/// Color Helper 함수
class ColorH {
  ColorH._privateConstructor();
  static final ColorH _instance = ColorH._privateConstructor();

  factory ColorH() {
    return _instance;
  }

  /// Main Color
  static Color main() {
    return Color(int.parse('${preHexCode}696DDC'));
  }

  /// active focus Color
  static Color active() {
    return Color(int.parse('${preHexCode}3C40C6'));
  }

  /// Read only Color
  static Color readonly() {
    return Color(int.parse('${preHexCode}D9DAFC'));
  }

  /// disalbed Color
  static Color disabled() {
    return Color(int.parse('${preHexCode}B3B6F9'));
  }

  /// default Text Color
  static Color defaultText() {
    return Color(int.parse('${preHexCode}333333'));
  }

  /// description: 16진수로 입력된 색상 코드를 받아서 Color 객체로 변환하는 함수
  /// @param { String } hexCode (변환할 HexCode)
  static Color hex(String hexCode) {
    // 16진수 유효성 체크
    if (hexCode.length != 6 || !RegExp(r'^[0-9a-fA-F]+$').hasMatch(hexCode)) {
      throw const FormatException("Invalid Hex Color Code");
    }

    return Color(int.parse("$preHexCode$hexCode"));
  }
}
