import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:goldvault/Constants/ColorConstant.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/CheckSellOtpModel.dart';
import 'package:goldvault/Screens/Success.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';

class ConfirmationSellGold extends StatefulWidget {
  final String sellVerificationId;
  const ConfirmationSellGold({Key? key, required this.sellVerificationId}) : super(key: key);

  @override
  State<ConfirmationSellGold> createState() => _ConfirmationSellGoldState();
}

class _ConfirmationSellGoldState extends State<ConfirmationSellGold> {

  List<CheckSellOtpResult> checkOtpResult =[];

  checkOtp(String otp) async {
    Map<String, dynamic> data = {
      "id": widget.sellVerificationId,
      "user_id": userId,
      "otp": otp,
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$check_sell_otp", body: data, context: context);
    print("status from api ${res}");
    final resdata = CheckSellOtpModel.fromJson(res);
    if (resdata.status == '1') {
      checkOtpResult = resdata.result;
      userAvailableGold = checkOtpResult[0].goldWallet;
      userAvailableAmount = checkOtpResult[0].amountWallet;

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Success(weight: checkOtpResult[0].goldSell, type: 'Sell',)));
      setState(() {});
    } else {
    }
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(context: context, title: "OTP Verification".tr),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                      child: ParagraphText(
                    text: "Enter the code that was sent to".tr,
                    fontSize: 18,
                  )),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  ParagraphText(
                    text: "+$userMobile",
                    fontSize: 18,
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  _otp_field(),
                  SizedBox(
                    height: height * 0.55,
                  ),
                  // ParagraphText(
                  //   text: "Resend Code"
                  // ),
                ],
              ),
            ),
          ),
          // Positioned(
          //     bottom: 0,
          //     child: Container(
          //       width: width,
          //       height: height * 0.07,
          //       color: ColorConstant.buttonColor,
          //       child: Center(
          //           child: Text(
          //         'CONTINUE',
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold),
          //       )),
          //     ))
        ],
      ),
    );
  }

  Widget _otp_field() {
    return OtpTextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        // contentPadding: EdgeInsets.symmetric(horizontal: 18),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Color(0xFFFFFFFF),
            )),
      ),
      cursorColor: Colors.grey,
      textStyle: TextStyle(
          color: Color(0xff000000), fontSize: 16, fontWeight: FontWeight.w700),

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
        checkOtp(verificationCode);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CreateNewPassword())
        // );
      },
    );
  }
}
