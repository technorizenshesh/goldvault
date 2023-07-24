import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goldvault/Constants/ColorConstant.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final bool isSolid;
  final double? width;
  final double? height;

  const CustomButton(
      {Key? key,
      required this.text,
      this.onTap,
      this.isSolid = true, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width??MediaQuery.of(context).size.width*0.5,
        height: height??MediaQuery.of(context).size.height*0.06,
        decoration: BoxDecoration(
          color: ColorConstant.buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontFamily: 'regular',fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
