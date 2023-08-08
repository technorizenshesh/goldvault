import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/SignupModel.dart';
import 'package:goldvault/Screens/HomePage.dart';
import 'package:goldvault/Screens/Login.dart';
import 'package:goldvault/Widgets/CustomSnackBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/ColorConstant.dart';
import '../Widgets/CustomButton.dart';
import '../Widgets/CustomTextField.dart';
import '../Widgets/CustomTexts.dart';
import 'package:http/http.dart' as http;
import 'package:goldvault/Constants/GlobalVariable.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conpasswordController = TextEditingController();
  TextEditingController referCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showPassword = true;
  bool showConPassword = true;

  Signup() async {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(passwordController.text)) {
      showSnackbar(context, 'Please Enter your valid password');
    } else {
      Map<String, dynamic> data = {
        "user_name": nameController.text,
        "email": emailController.text,
        "mobile": "",
        "password": passwordController.text,
        "other_referral_code": referCodeController.text
      };
      var res = await Webservices.postData(
          apiUrl: "$baseUrl$register", body: data, context: context);
      print("status from api ${res}");
      final resdata = SignupModel.fromJson(res);
      print("status.....${resdata.status}");
      if (resdata.status == '1') {
        userId = resdata.result.id;
        userName = resdata.result.userName;
        userMailId = resdata.result.email;
        userMobile = resdata.result.mobile;
        userToken = resdata.result.token;
        userImage = resdata.result.image;
        userAvailableGold = resdata.result.goldWallet;
        userAvailableAmount = resdata.result.amountWallet;
        referalCode = resdata.result.referralCode;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var save = prefs.setString('UserId', resdata.result.id);
        print("sp is....$save");
      } else {
        showSnackbar(context, 'Signing up failed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Container(
                height: height * 0.9,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: MainHeadingText(text: "Welcome!".tr),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: SubHeadingText(text: "Create Account".tr)),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      CustomTextField(
                        controller: nameController,
                        hintText: "Full Name".tr,
                        prefixIcon: "assets/images/NameIcon.svg",
                        errormsg: 'Enter Full name'.tr,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      CustomTextField(
                        controller: emailController,
                        hintText: "Email Address".tr,
                        prefixIcon: "assets/images/EmailIcon.svg",
                        errormsg: 'Enter Email'.tr,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        hintText: "Password".tr,
                        obscureText: showPassword,
                        prefixIcon: "assets/images/PasswordIcon.svg",
                        suffixIcon: "assets/images/HidePassIcon.svg",
                        suffixAction: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        errormsg: 'Enter password'.tr,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      CustomTextField(
                        controller: conpasswordController,
                        hintText: "Repeat Password".tr,
                        obscureText: showConPassword,
                        prefixIcon: "assets/images/PasswordIcon.svg",
                        suffixIcon: "assets/images/HidePassIcon.svg",
                        suffixAction: () {
                          setState(() {
                            showConPassword = !showConPassword;
                          });
                        },
                        errormsg: conpasswordController.text == ""
                            ? 'confirm password'.tr
                            : conpasswordController.text !=
                                    passwordController.text
                                ? "password and confirmed password are not same".tr
                                : "",
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      SubHeadingText(text: "Enter refer code to get rewards".tr),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 100),
                        child: CustomTextField(
                          controller: referCodeController,
                          hintText: "Enter code here".tr,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      CustomButton(
                        text: "NEXT".tr,
                        width: width * 0.8,
                        height: height * 0.05,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            // signup(
                            //   nameController.text,emailController.text,passwordController.text
                            // );
                            Signup();
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      SubHeadingText(
                        text: "Or Continue with".tr,
                        fontSize: 15,
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: height * 0.1,
                              width: width * 0.4,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    "assets/images/FacebookButton.svg",
                                    fit: BoxFit.fill,
                                  ))),
                          Container(
                              height: height * 0.1,
                              width: width * 0.4,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    "assets/images/GoogleButton2.png",
                                    height: 45,
                                    width: 120,
                                    fit: BoxFit.fill,
                                  ))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ParagraphText(
                        text: "Already have an account?".tr,
                        color: Colors.grey,
                        fontSize: 17,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          "SIGN IN".tr,
                          style: TextStyle(
                            color: ColorConstant.textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
