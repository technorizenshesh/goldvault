import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/CheckOtpModel.dart';
import 'package:goldvault/Screens/Login.dart';

import '../Widgets/CustomAppBar.dart';
import '../Widgets/CustomButton.dart';
import '../Widgets/CustomTextField.dart';
import '../Widgets/CustomTexts.dart';

class CreateNewPassword extends StatefulWidget {
  final String email;
  const CreateNewPassword({Key? key, required this.email}) : super(key: key);

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  TextEditingController passwordController= TextEditingController();
  TextEditingController conpasswordController= TextEditingController();
  final _formKey = GlobalKey<FormState>();

  changePassword() async {
    Map<String, dynamic> data = {
      "password": passwordController.text.toString(),
      "email": widget.email
    };
    print("data...$data");
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$reset_password", body: data, context: context);
    print("status from api ${res}");
    final resdata = CheckOtpModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Login()));

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height*0.03,),
                MainHeadingText(text: "Create new password".tr,fontSize: 20),
                SizedBox(height: height*0.03,),
                Padding(padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: ParagraphText(text: "Your new password must be unique from those previously used least 8 character, number.".tr,height: 1.5,
                      textAlign: TextAlign.center,)),
                SizedBox(height: height*0.05,),
                CustomTextField(
                  controller: passwordController,
                  hintText: "Password".tr,
                  prefixIcon: "assets/images/PasswordIcon.svg",
                  suffixIcon: "assets/images/HidePassIcon.svg",
                  errormsg: 'Enter password'.tr,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextField(
                  controller: conpasswordController,
                  hintText: "Repeat Password".tr,
                  prefixIcon: "assets/images/PasswordIcon.svg",
                  suffixIcon: "assets/images/HidePassIcon.svg",
                  errormsg: 'Confirm password'.tr,
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                CustomButton(
                  text: "RESET PASSWORD".tr,
                  width: width * 0.8,
                  height: height * 0.06,
                  onTap: (){
                    if (_formKey.currentState!.validate()) {
                      if(passwordController.text.toString()==conpasswordController.text.toString()){
                        changePassword();
                      }
                      else{
                        const snackbar = SnackBar(
                          content: Text("Password and Confirm password are not same"),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }                    }

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
