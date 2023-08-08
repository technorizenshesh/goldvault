import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';

import 'package:goldvault/Constants/image_picker.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomButton.dart';
import 'package:goldvault/Widgets/CustomSnackBar.dart';
import 'package:goldvault/Widgets/CustomTextField.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';
import 'package:goldvault/Models/UserVerificationModel.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController bankController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  File? imageIdFront;
  File? imageIdBack;
  File? imageBankStatment;

  var type;

  UserVerificationResult? verificationResult;

  verifyUser() async {
    Map<String, dynamic> data = {
      "user_id": userId,
      "first_name": fNameController.text.toString(),
      "last_name": lNameController.text.toString(),
      "address": addressController.text.toString(),
      "bank_number": bankController.text.toString(),
      "country": countryController.text.toString(),
      "zipcode": zipController.text.toString(),
      "city": cityController.text.toString(),
    };

    Map<String, dynamic> files = {};
    files["front_image"]=imageIdFront;
    files["back_image"]=imageIdBack;
    files["bank_statement"]=imageBankStatment;

    var res = await Webservices.postDataWithImageFunction(
        apiUrl: "$baseUrl$add_users_verification",
        body: data,
        context: context,
        files: files);
    print("status from api ${res}");
    final resdata = UserVerificationModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      verificationResult = resdata.result;
      showSnackbar(context, "Request sent for verification");
      Navigator.pop(context);

    } else {
      showSnackbar(context, "Request couldn't be sent");
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(context: context, title: "Verification".tr),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: fNameController,
                  hintText: "First Name".tr,
                  errormsg: 'Enter Name'.tr,
                ),
                CustomTextField(
                  controller: lNameController,
                  hintText: "Last Name",
                  errormsg: 'Enter Last Name'.tr,
                ),
                CustomTextField(
                  controller: addressController,
                  hintText: "Address".tr,
                  errormsg: 'Enter Address'.tr,
                ),
                CustomTextField(
                  controller: cityController,
                  hintText: "City".tr,
                  errormsg: 'Enter City'.tr,
                ),
                CustomTextField(
                  controller: zipController,
                  hintText: "Zip code".tr,
                  errormsg: 'Enter Zip code'.tr,
                ),
                CustomTextField(
                  controller: countryController,
                  hintText: "Country".tr,
                  errormsg: 'Enter Country'.tr,
                ),
                CustomTextField(
                  controller: bankController,
                  hintText: "Bank Number".tr,
                  errormsg: 'Enter Bank Number'.tr,
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 0.25,
                      height: height * 0.2,
                      child: Column(
                        children: [
                          ParagraphText(
                            text: "Photo of ID Front".tr,
                            textAlign: TextAlign.center,
                            fontSize: 18,
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              type = "idFront";
                              _showImage_popup(context, type);
                            },
                            child: Container(
                              width: width * 0.2,
                              height: height * 0.1,
                              child: imageIdFront == null
                                  ? Icon(
                                      Icons.add,
                                      size: 40,
                                      color: Colors.grey,
                                    )
                                  : Container(
                                      width: width * 0.2,
                                      height: height * 0.1,
                                      child: Image.file(
                                        imageIdFront!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.25,
                      height: height * 0.2,
                      child: Column(
                        children: [
                          ParagraphText(
                            text: "Photo of ID Back".tr,
                            textAlign: TextAlign.center,
                            fontSize: 18,
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              type = "idBack";
                              _showImage_popup(context, type);
                            },
                            child: Container(
                              width: width * 0.2,
                              height: height * 0.1,
                              child: imageIdBack == null
                                  ? Icon(
                                Icons.add,
                                size: 40,
                                color: Colors.grey,
                              )
                                  : Container(
                                color: Colors.yellow,
                                width: width * 0.2,
                                height: height * 0.1,
                                child: Image.file(
                                  imageIdBack!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.25,
                      height: height * 0.2,
                      child: Column(
                        children: [
                          ParagraphText(
                            text: "Bank Statement".tr,
                            textAlign: TextAlign.center,
                            fontSize: 18,
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              type = "bankStatement".tr;
                              _showImage_popup(context, type);
                            },
                            child: Container(
                              width: width * 0.2,
                              height: height * 0.1,
                              child: imageBankStatment == null
                                  ? Icon(
                                Icons.add,
                                size: 40,
                                color: Colors.grey,
                              )
                                  : Container(
                                color: Colors.yellow,
                                width: width * 0.2,
                                height: height * 0.1,
                                child: Image.file(
                                  imageBankStatment!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                ParagraphText(
                  text:
                      "Photos  must  be  clear  and  readable.  Photo of bank  statement  must  show your  name  and  adress".tr,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                CustomButton(
                  text: "SAVE".tr,
                  width: width * width,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if(imageIdFront==null){
                        showSnackbar(context, "add id front image".tr);
                      }
                      else if(imageIdBack==null){
                        showSnackbar(context, "add id back image".tr);

                      }
                      else if(imageBankStatment==null){
                        showSnackbar(context, "add bank statement".tr);
                      }
                      else{
                        verifyUser();
                      }

                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImage_popup(BuildContext ctx, String type) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () async {
                      if (type == "idFront") {
                        imageIdFront = await pickImage(false);
                      } else if (type == "idBack") {
                        imageIdBack = await pickImage(false);
                      } else if (type == "bankStatement") {
                        imageBankStatment = await pickImage(false);
                      }
                      setState(() {});
                      Navigator.of(ctx).pop();
                    },
                    child:  Text('Take Camera'.tr)),
                CupertinoActionSheetAction(
                    onPressed: () async {
                      //  image = await pickImage(true);
                      if (type == "idFront") {
                        imageIdFront = await pickImage(true);
                      } else if (type == "idBack") {
                        imageIdBack = await pickImage(true);
                      } else if (type == "bankStatement") {
                        imageBankStatment = await pickImage(true);
                      }
                      //  print("image is....$image");
                      setState(() {});
                      Navigator.of(ctx).pop();
                    },
                    child:  Text('Gallery'.tr)),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () => Navigator.of(ctx).pop(),
                child:  Text('Close'.tr),
              ),
            ));
  }
}
