import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatelessWidget {
  final bool? enabled;
  final TextEditingController controller;
  final String hintText;
  final BoxBorder? border;
  final bool horizontalPadding;
  final bool obscureText;
  final int? maxLines;
  final Color bgColor;
  final Color borderColor;
  final Color? textcolor;
  final double verticalPadding;
  final double borderradius;
  final String? prefixIcon;
  final String? suffixIcon;
  final String? errormsg;
  final TextAlign textAlign;
  final Function()? onTap;
  final Function()? suffixAction;
  final bool? isValidator;
  final bool isEditable;
  final TextInputType? keyboardType;
  CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.border,
    this.maxLines,
    this.horizontalPadding = false,
    // this.verticalPadding = false,
    this.obscureText = false,
    this.bgColor = Colors.transparent,
    this.borderColor = Colors.transparent,
    this.textcolor,
    this.verticalPadding = 4,
    this.prefixIcon,
    this.suffixIcon,
    this.textAlign = TextAlign.left,
    this.enabled,
    this.borderradius = 30,
    this.onTap,
    this.suffixAction,
    this.errormsg,
    this.isValidator = true, this.isEditable=false, this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(
          horizontal: horizontalPadding ? 16 : 0, vertical: verticalPadding),
      decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderColor),
          // border: Border,
          borderRadius: BorderRadius.circular(borderradius)),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        // focusNode: FocusNode,

        readOnly: isEditable,
        enabled: enabled,
        maxLines: maxLines ?? 1,
        controller: controller,
        obscureText: obscureText,
        textAlign: textAlign,
        keyboardType: keyboardType,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintStyle: TextStyle(fontSize: 16, color: textcolor ?? null),
          // focusedBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(5.0)),
          //     borderSide: BorderSide(color: Colors.orange)),

          border: InputBorder.none,
          prefixIcon: prefixIcon == null
              ? null
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    prefixIcon!,
                    color: Colors.grey,
                    width: 10,
                    height: 10,
                    fit: BoxFit.fitHeight,
                  ),
                ),
          suffixIcon: suffixIcon == null
              ? null
              : GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: suffixAction,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      suffixIcon!,
                      color: Colors.grey,
                      width: 10,
                      height: 10,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
        ),
        validator: isValidator == true
            ? (con) {
                if (con == null || con.isEmpty) {
                  return errormsg;
                }
                return null;
              }
            : null,
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String errormsg;

  const CustomTextFormField(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.errormsg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: labelText,
            prefixIcon: Image.asset('assets/images/Profile.png')),
        validator: (con) {
          if (con == null || con.isEmpty) {
            return errormsg;
          }
          return null;
        },
      ),
    );
  }
}
