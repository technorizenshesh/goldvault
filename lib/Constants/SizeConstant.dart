import 'package:flutter/cupertino.dart';

class SizeConstant{
  static var screenWidth;
  static var screenHeight;

  void init(BuildContext context){
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
}
