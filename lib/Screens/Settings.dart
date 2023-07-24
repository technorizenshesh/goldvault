import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goldvault/Constants/ColorConstant.dart';
import 'package:goldvault/Screens/ChangePassword.dart';
import 'package:goldvault/Screens/Verification.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isNotification = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(context: context, title: "Setting"),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ListTile(
              title: SubHeadingText(
                text: "Allow Notifcations".tr,
                fontWeight: FontWeight.bold,
              ),
              trailing: InkWell(
                onTap: () {
                  setState(() {
                    isNotification = !isNotification;
                  });
                },
                child: Switch(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: ColorConstant.buttonColor,
                  inactiveTrackColor:
                      ColorConstant.buttonColor.withOpacity(0.4),
                  value: isNotification,
                  onChanged: (newValue) {
                    setState(() {
                      isNotification = newValue;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            ListTile(
              onTap: () {
                showSheet();
              },
              title: SubHeadingText(
                text: "Language".tr,
                fontWeight: FontWeight.bold,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: ColorConstant.buttonColor,
                size: 20,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            ListTile(
              title: SubHeadingText(
                text: "Change password".tr,
                fontWeight: FontWeight.bold,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: ColorConstant.buttonColor,
                size: 20,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangePassword()));
              },
            ),
            SizedBox(
              height: height * 0.01,
            ),
            ListTile(
              title: SubHeadingText(
                text: "Rate us".tr,
                fontWeight: FontWeight.bold,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: ColorConstant.buttonColor,
                size: 20,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            ListTile(
              title: SubHeadingText(
                text: "Share this app".tr,
                fontWeight: FontWeight.bold,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: ColorConstant.buttonColor,
                size: 20,
              ),
              onTap: () {
                share();
              },
            ),
            SizedBox(
              height: height * 0.01,
            ),
            ListTile(
              title: SubHeadingText(
                text: "Verification".tr,
                fontWeight: FontWeight.bold,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: ColorConstant.buttonColor,
                size: 20,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Verification()));
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> share() async {
    print("object...");
    await FlutterShare.share(
        title: 'Example share',
        text: 'Install app',
        linkUrl: 'https://play.google.com/store/apps/details',
        chooserTitle: 'Example Chooser Title');
  }

  showSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.45,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        updateLanguage(Locale('sk','SK'));
                      },
                      child: Row(
                        children: [
                          AppBarHeadingText(
                            text: "Slovak",
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.001,
                      color: Colors.black12,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        updateLanguage(Locale('cs','CZ'));
                      },
                      child: Row(
                        children: [
                          AppBarHeadingText(
                            text: "Czech",
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.001,
                      color: Colors.black12,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        updateLanguage(Locale('pl','PL'));
                      },
                      child: Row(
                        children: [
                          AppBarHeadingText(
                            text: "Polish",
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.001,
                      color: Colors.black12,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        updateLanguage(Locale('hu','HU'));
                      },
                      child: Row(
                        children: [
                          AppBarHeadingText(
                            text: "Hungarian",
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.001,
                      color: Colors.black12,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        updateLanguage(Locale('de','AT'));
                      },
                      child: Row(
                        children: [
                          AppBarHeadingText(
                            text: "German",
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.001,
                      color: Colors.black12,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        updateLanguage(Locale('en','US'));
                      },
                      child: Row(
                        children: [
                          AppBarHeadingText(
                            text: "English",
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  updateLanguage(Locale locale) async{
    Get.updateLocale(locale);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', locale.toString());
  }
}
