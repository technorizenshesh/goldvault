import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goldvault/Constants/ColorConstant.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Screens/AboutGoldVault.dart';
import 'package:goldvault/Screens/EditProfile.dart';
import 'package:goldvault/Screens/FAQ.dart';
import 'package:goldvault/Screens/GetSupport.dart';
import 'package:goldvault/Screens/Login.dart';
import 'package:goldvault/Screens/PrivaryNotice.dart';
import 'package:goldvault/Screens/Settings.dart';
import 'package:goldvault/Screens/TermsConditionScreen.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomTextField.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(context: context, title: "Profile".tr, implyLeading: false),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfile()));
              },
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    width: width * 0.15,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: ColorConstant.buttonColor,
                    ),
                    child:  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: CachedNetworkImage(imageUrl: userImage,
                        fit: BoxFit.cover,
                      ),
                    )
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubHeadingText(
                        text: "$userName",
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      ParagraphText(
                        text: '$userMailId',
                      )
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              leading: SvgPicture.asset("assets/images/GetSupportIcon.svg"),
              title:
              SubHeadingText(
                text: 'Get Support'.tr,
              ),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetSupport()));
              },
            ),
            ListTile(
              leading: SvgPicture.asset("assets/images/SettingsIcon.svg"),
              title: SubHeadingText(
                text: 'Settings'.tr,
              ),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Settings()));
              },
            ),
            ListTile(
              leading: SvgPicture.asset("assets/images/AboutIcon.svg"),
              title: SubHeadingText(
                text: 'About Gold Vault'.tr,
              ),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AboutGoldVault()));
              },
            ),
            ListTile(
              leading: SvgPicture.asset("assets/images/FAQIcon.svg"),
              title: SubHeadingText(
                text: 'FAQ'.tr,
              ),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FAQ()));
              },
            ),
            ListTile(
              leading: SvgPicture.asset("assets/images/T&CIcon.svg"),
              title: SubHeadingText(
                text: 'Terms and Conditions'.tr,
              ),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TermsConditionScreen()));
              },
            ),
            ListTile(
              leading: SvgPicture.asset("assets/images/PrivacyPolicyIcon.svg"),
              title: SubHeadingText(
                text: 'Privacy Notice'.tr,
              ),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrivacyNotice()));
              },
            ),
            ListTile(
              leading: SvgPicture.asset("assets/images/LogoutIcon.svg"),
              title: SubHeadingText(
                text: 'LogOut'.tr,
              ),
              onTap: (){
                _showDialog(context);
              }
            )
          ],
        ),
      ),
    );
  }
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
          Text("Log Out".tr, style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text("Are you sure you want to Log out?".tr),
          actions: <Widget>[
            TextButton(
              child: new Text("No".tr,
                  style: TextStyle(
                      color: ColorConstant.buttonColor, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes".tr,
                  style: TextStyle(
                      color:ColorConstant.buttonColor, fontWeight: FontWeight.bold)),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Login()));
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();

              },
            ),
          ],
        );
      },
    );
  }
}
