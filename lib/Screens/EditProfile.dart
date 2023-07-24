import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goldvault/Constants/ColorConstant.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/image_picker.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/UpdateProfileModel.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomButton.dart';
import 'package:goldvault/Widgets/CustomTextField.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //TextEditingController pNameController= TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  //File? previousImage;
  File? image;

  @override
  void initState() {
    super.initState();
    print(
        "id....$userId,$userName,$userMailId,$userMobile,$userAddress,$userCity,$userCountry");
    // previousImage = File(userImage);
    lNameController.text = userName;
    emailController.text = userMailId;
    mobileController.text = userMobile;
    addressController.text = userAddress;
    cityController.text = userCity;
    countryController.text = userCountry;
  }

  editProfile() async {
    Map<String, dynamic> data = {
      "user_name": lNameController.text,
      "mobile": mobileController.text.toString(),
      "country": countryController.text.toString(),
      "city": cityController.text.toString(),
      "address": addressController.text.toString(),
      "user_id": userId,
    };

    Map<String, dynamic> files = {};
    if (image != null) {
      files["image"] = image;
    } else {
      files["image"] == "";
    }
    print("eeee,,,,$files,,,,$data");
    var res = await Webservices.postDataWithImageFunction(
        apiUrl: "$baseUrl$update_profile",
        body: data,
        context: context,
        files: files);
    print("status from api ${res}");
    final resdata = UpdateProfileModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      userName = resdata.result[0].userName;
      userMobile = resdata.result[0].mobile;
      userCountry = resdata.result[0].country;
      userCity = resdata.result[0].city;
      userAddress = resdata.result[0].address;
      userImage = resdata.result[0].image;
      setState(() {

      });
      Navigator.pop(context);
    } else {
      const snackbar = SnackBar(
        content: Text("Updation failed"),
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
        appBar: appBar(context: context, title: "Edit Profile", actions: [
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: SvgPicture.asset("assets/images/iButtonIcon.svg"))
        ]),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                cameraWidget(),
                SizedBox(
                  height: height * 0.01,
                ),
                // CustomTextField(controller: pNameController, hintText: "Preferred Name",suffixIcon: "assets/images/EditIcon.svg",isValidator: false),
                // SizedBox(height: height*0.01,),
                CustomTextField(
                  controller: lNameController,
                  hintText: "Legal Name",
                  isValidator: false,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                CustomTextField(
                  controller: emailController,
                  hintText: "Email Address",
                  isValidator: false,
                  isEditable: true,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                CustomTextField(
                  controller: mobileController,
                  hintText: "Mobile Number",
                  isValidator: false,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                // CustomTextField(
                //   controller: accountController,
                //   hintText: "Account Number",
                //   isValidator: false,
                // ),
                // SizedBox(
                //   height: height * 0.01,
                // ),
                CustomTextField(
                  controller: addressController,
                  hintText: "Address",
                  isValidator: false,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                CustomTextField(
                  controller: cityController,
                  hintText: "City",
                  isValidator: false,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                // CustomTextField(
                //   controller: zipController,
                //   hintText: "Zip code",
                //   isValidator: false,
                // ),
                // SizedBox(
                //   height: height * 0.01,
                // ),
                CustomTextField(
                  controller: countryController,
                  hintText: "Country",
                  isValidator: false,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomButton(
                  text: "SAVE",
                  width: width * width,
                  onTap: () {
                    if (image == null) {
                      const snackbar = SnackBar(
                        content: Text("Select image"),
                        backgroundColor: Colors.red,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    } else {
                      editProfile();
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }

  cameraWidget() {
    return InkWell(
      onTap: () {
        _showImage_popup(context);
      },
      child: SizedBox(
        height: 90,
        width: 90,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstant.buttonColor,
              ),
              child: Padding(
                  padding: EdgeInsets.all(3),
                  child: image == null
                      ? ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          child: CachedNetworkImage(
                              imageUrl: userImage,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                        )
                  // CircleAvatar(
                  //   backgroundImage: AssetImage("assets/images/ProfileImg.png"),
                  // ),
                  ),
            ),
            Positioned(
                bottom: -10,
                right: 30,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstant.buttonColor,
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 18,
                      )),
                  //padding: EdgeInsets.all(1.0),
                )),
          ],
        ),
      ),
    );
  }

  void _showImage_popup(
    BuildContext ctx,
  ) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () async {
                      image = await pickImage(false);
                      setState(() {});
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Take Camera')),
                CupertinoActionSheetAction(
                    onPressed: () async {
                      image = await pickImage(true);
                      print("image is....$image");
                      setState(() {});
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Gallery')),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Close'),
              ),
            ));
  }
}
