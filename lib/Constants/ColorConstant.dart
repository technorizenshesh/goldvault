import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
  'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class ColorConstant {
  static Color buttonColor = hexToColor('#FFC727');
  static Color yellowOpacityColor = hexToColor('#DEAD20');
  static Color textColor = hexToColor('#FF5000');
  static Color bluegreenColor = hexToColor('#00B6AA');
  static Color lightGreen = hexToColor('#53D633');
  static Color lightGreen1 = hexToColor('#42CE00');


  static Color readmoreColor = hexToColor('#6D1837');
  static Color orangeColor = hexToColor('#FF6500');
  static Color pinkColor =  hexToColor('#EE87AB');
  static Color pinkColor1 =  hexToColor('#964765');
  static Color pinkColor2 =  hexToColor('#E4BDBF');
  static Color blueColor =  hexToColor('#72AAE0');

  static const primaryColor = Color(0xFF6358E1);

  static const textBlack = Color(0xFF1F2022);
  static const white = Color(0xFFFFFFFF);
  static const grey = Color(0xFFB6BDC6);
  static const loadingBlack = Color(0x80000000);

  static const textFieldBackground = Color(0xFFFBFCFF);
  static const textFieldBorder = Color(0xFFB9BBC5);

  static const disabledColor = Color(0xFFE1E1E5);
  static const errorColor = Color(0xFFF25252);

  static const homeBackgroundColor = Color.fromRGBO(252, 252, 252, 1);
  static const textGrey = Color(0xFF8F98A3);

  static const cardioColor = Color(0xFFFCB74F);
  static const armsColor = Color(0xFF5C9BA4);
}