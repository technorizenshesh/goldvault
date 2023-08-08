import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/CheckOtpModel.dart';
import 'package:goldvault/Screens/CreateNewPassword.dart';

import '../Widgets/CustomAppBar.dart';
import '../Widgets/CustomTexts.dart';

class OtpVerification extends StatefulWidget {
  final String email;
  const OtpVerification({Key? key, required this.email}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  verifyOtp(String otp) async {
    Map<String, dynamic> data = {
      "email": widget.email,
      "otp": otp
    };
    print("data...$data");
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$check_otp", body: data, context: context);
    print("status from api ${res}");
    final resdata = CheckOtpModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => CreateNewPassword(email: widget.email)));

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
              SizedBox(height: height*0.03,),
              MainHeadingText(text: "OTP Verification".tr,fontSize: 20),
              SizedBox(height: height*0.03,),
              Padding(padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: ParagraphText(text: "Enter the verification code we just sent on your email address.".tr,height: 1.5,
                    textAlign: TextAlign.center,)),
              SizedBox(height: height*0.05,),
              _otp_field()
            ],
          ),
        ),
      ),
    );
  }
  Widget _otp_field() {

    return  OtpTextField(

      decoration: InputDecoration(border: InputBorder.none,
        // contentPadding: EdgeInsets.symmetric(horizontal: 18),
        focusedBorder: const OutlineInputBorder(

            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Color(0xFFFFFFFF),)),),
      cursorColor: Colors.grey,
      textStyle:TextStyle(
          color: Color(0xff000000),fontSize: 16,fontWeight: FontWeight.w700
      ) ,

      borderRadius: BorderRadius.circular(10),
      numberOfFields: 4,
      borderColor: Color(0xFFFFFFFF),
      focusedBorderColor: Colors.black,

      showFieldAsBox: true,
      borderWidth: 0.5,
      enabledBorderColor: Colors.black26,
      fieldWidth: 50,


      //runs when a code is typed in
      onCodeChanged: (String code) {
        //handle validation or checks here if necessary
      },
      //runs when every textfield is filled
      onSubmit: (String verificationCode) {
        verifyOtp(verificationCode);
      },
    );
  }
}
