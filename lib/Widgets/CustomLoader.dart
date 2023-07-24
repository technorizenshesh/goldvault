import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:goldvault/Constants/ColorConstant.dart';

class CustomLoader extends StatelessWidget {
  final Color? color;
  final double? radius;
  CustomLoader({Key? key, this.color,this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: CircularProgressIndicator(
    //     color:color?? MyColors.primaryColor,
    //   ),
    // );
    return Center(
        child: cupertino.CupertinoActivityIndicator(
          color:color??Colors.white,
          radius:radius?? 10,
        )
    );
    // return cupertino.CupertinoActivityIndicator
  }
}
