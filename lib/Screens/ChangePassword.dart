import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/UpdatePasswordModel.dart';
import 'package:goldvault/Models/UpdateProfileModel.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomButton.dart';
import 'package:goldvault/Widgets/CustomTextField.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController conPasswordController = TextEditingController();
  bool hideCurrentPassword = true;
  bool hideNewPassword = true;
  bool hideConfirmPassword = true;

  updatePassword() async {
    Map<String, dynamic> data = {
      "user_id": userId,
      "old_password": currentPasswordController.text,
      "password": newPasswordController.text,
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$update_password", body: data, context: context);
    print("status from api ${res}");
    final resdata = UpdatePasswordModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      Navigator.pop(context);
      const snackbar = SnackBar(
        content: Text("Password updated successfully"),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      const snackbar = SnackBar(
        content: Text("Password updation failed"),
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
      appBar: appBar(context: context, title: "Change Password".tr),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                controller: currentPasswordController,
                hintText: "Current Password".tr,
                obscureText: hideCurrentPassword,
                suffixIcon: hideCurrentPassword==true?"assets/images/HidePassIcon.svg":"assets/images/HidePassIcon.svg",
                errormsg: 'Enter password'.tr,
                suffixAction: () {
                  setState(() {
                    hideCurrentPassword = !hideCurrentPassword;
                  });
                },
              ),
              SizedBox(
                height: height * 0.03,
              ),
              CustomTextField(
                controller: newPasswordController,
                hintText: "New Password".tr,
                obscureText: hideNewPassword,
                suffixIcon: hideNewPassword==true?"assets/images/HidePassIcon.svg":"assets/images/HidePassIcon.svg",
                errormsg: 'Enter password'.tr,
                suffixAction: () {
                  setState(() {
                    hideNewPassword = !hideNewPassword;
                  });
                },
              ),
              SizedBox(
                height: height * 0.03,
              ),
              CustomTextField(
                controller: conPasswordController,
                hintText: "Confirm Password".tr,
                obscureText: hideConfirmPassword,
                suffixIcon: hideConfirmPassword==true?"assets/images/HidePassIcon.svg":"assets/images/ShowPassIcon.svg",
                errormsg: 'Enter password'.tr,
                suffixAction: () {
                  setState(() {
                    hideConfirmPassword = !hideConfirmPassword;
                  });
                },
              ),
              SizedBox(
                height: height * 0.1,
              ),
              CustomButton(
                text: "SAVE".tr,
                width: width * width,
                onTap: () {
                  if (currentPasswordController.text.isEmpty) {
                    const snackbar = SnackBar(
                      content: Text("Enter old password"),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                  else{
                    if(newPasswordController.text.isEmpty){
                      const snackbar = SnackBar(
                        content: Text("Enter new password"),
                        backgroundColor: Colors.red,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                    else{
                      if(conPasswordController.text.isEmpty){
                        const snackbar = SnackBar(
                          content: Text("Confirm password"),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                      else{
                        if(newPasswordController.text!=conPasswordController.text){
                          const snackbar = SnackBar(
                            content: Text("New password and confirm password are not same"),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                        else{
                          updatePassword();
                        }
                      }
                    }
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
