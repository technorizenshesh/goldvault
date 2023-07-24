import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/GeneralModel.dart';
import 'package:goldvault/Screens/HomePage.dart';
import 'package:goldvault/Screens/OtpVerification.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';

import '../Constants/ColorConstant.dart';
import '../Widgets/CustomButton.dart';
import '../Widgets/CustomTextField.dart';
import '../Widgets/CustomTexts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  SendOtp() async {
    Map<String, dynamic> data = {
      "email": emailController.text,
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$forgot_password", body: data, context: context);
    print("status from api ${res}");
    final resdata = GeneralModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpVerification(
                    email: emailController.text.toString(),
                  )));
      emailController.clear();
    } else {
      const snackbar = SnackBar(
        content: Text("OTP not sent"),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  ResendOtp() async {
    Map<String, dynamic> data = {
      "email": emailController.text,
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$resend_otp", body: data, context: context);
    print("status from api ${res}");
    final resdata = GeneralModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {

      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpVerification(
                    email: emailController.text.toString(),
                  )));
      emailController.clear();
    } else {
      const snackbar = SnackBar(
        content: Text("OTP not sent"),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(context: context),
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/ForgotPasswordImage.svg',
                height: 200,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              MainHeadingText(text: "Forgot Password?", fontSize: 20),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: ParagraphText(
                    text:
                        "Don't worry! It occurs. Please enter the email address linked with your account.New code will be received after 60 seconds",
                    height: 1.5,
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                height: height * 0.03,
              ),
              CustomTextField(
                controller: emailController,
                hintText: "Email",
                prefixIcon: "assets/images/EmailIcon.svg",
                errormsg: 'Confirm password',
              ),
              SizedBox(
                height: height * 0.05,
              ),
              CustomButton(
                text: "SEND",
                width: width * 0.8,
                height: height * 0.05,
                onTap: () {
                  SendOtp();
                },
              ),
              SizedBox(
                height: height * 0.05,
              ),
              TextButton(
                child: Text("ResendOTP",
                    style: TextStyle(
                      color: ColorConstant.textColor,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    )),
                onPressed: () {
                  if(emailController.text!=""){
                    ResendOtp();
                  }
                  else{
                    const snackbar = SnackBar(
                      content: Text("Enter email"),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
