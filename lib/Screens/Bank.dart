import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:goldvault/Constants/ColorConstant.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomTextField.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';

class Bank extends StatefulWidget {
  const Bank({Key? key}) : super(key: key);

  @override
  State<Bank> createState() => _BankState();
}

class _BankState extends State<Bank> {
  TextEditingController accNumberController = TextEditingController(text: "1234567890");
  TextEditingController codeController = TextEditingController(text: "ABCD1234");
  TextEditingController nameController = TextEditingController(text: "Gold");

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(context: context,title: 'Bank'.tr),
      body:
      Stack(
        children: [
          Column(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.03,
                      ),
                      SubHeadingText(text: 'Account Number'.tr),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      CustomTextField(
                        isEditable: true,
                        controller: accNumberController,
                        hintText: "Enter Account Number".tr,
                        borderColor: Colors.black12,
                        borderradius: 10,
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      SubHeadingText(text: 'BIC/SWIFT'.tr),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      CustomTextField(
                        isEditable: true,
                        controller: codeController,
                        hintText: "Enter Code".tr,
                        borderColor: Colors.black12,
                        borderradius: 10,
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      SubHeadingText(text: 'Reference'.tr),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      CustomTextField(
                        isEditable: true,
                        controller: nameController,
                        hintText: "Enter Name".tr,
                        borderColor: Colors.black12,
                        borderradius: 10,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
              bottom: 0,
              child: Container(
                width: width,
                height: height * 0.07,
                color: ColorConstant.buttonColor,
                child: Center(
                    child: Text(
                      'CHECK OUT'.tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
              ))

        ],
      ),
    );
  }
}
