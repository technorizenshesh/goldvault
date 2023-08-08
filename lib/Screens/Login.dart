import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goldvault/Constants/ColorConstant.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/SizeConstant.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/SignupModel.dart';
import 'package:goldvault/Screens/HomePage.dart';
import 'package:goldvault/Screens/Signup.dart';
import 'package:goldvault/Widgets/CustomButton.dart';
import 'package:goldvault/Widgets/CustomSnackBar.dart';
import 'package:goldvault/Widgets/CustomTextField.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants/globalVaribles.dart';
import 'ForgotPassword.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool showPassword = true;

  Signin() async {
    var user = {
      "email": emailController.text,
      "password": passwordController.text,
      "register_id": tokenId,
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$login", body: user, context: context);
    print("status from api ${res}");
    final resdata = SignupModel.fromJson(res);
    print(resdata);
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
      prefs.setString('UserId', resdata.result.id);
    } else {
      showSnackbar(context,'logging failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.fromLTRB(20, 140, 20, 20),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Container(
                height: height * 0.8,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: MainHeadingText(text: "Welcome Back!".tr),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: SubHeadingText(text: "Login to continue".tr)),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    CustomTextField(
                      controller: emailController,
                      hintText: "Email".tr,
                      prefixIcon: "assets/images/EmailIcon.svg",
                      errormsg: 'Enter Email',
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      obscureText: showPassword,
                      hintText: "Password".tr,
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
                      height: height * 0.05,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()));
                        },
                        child: Text(
                          "Forgot Password".tr,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        )),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    CustomButton(
                      text: "NEXT".tr,
                      width: width * 0.8,
                      height: height * 0.05,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Signin();
                        }
                      },
                    ),
                    SizedBox(
                      height: height * 0.08,
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
            Positioned(
                bottom: 0,
                child: Container(
                  width: width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ParagraphText(
                        text: "Don't have an account?".tr,
                        color: Colors.grey,
                        fontSize: 17,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup()));
                        },
                        child: Text(
                          "SIGN UP".tr,
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
