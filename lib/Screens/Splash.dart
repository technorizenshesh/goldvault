import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goldvault/Constants/AppLocalizations.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/GetUserProfileModel.dart';
import 'package:goldvault/Screens/HomePage.dart';
import 'package:goldvault/Screens/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var savedUid;
  var locale;

  getUserProfileData() async {
    Map<String, dynamic> data = {
      "user_id": savedUid,
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$get_profile", body: data, context: context);
    print("status from api ${res}");
    final resdata = GetUserProfileModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      userId = resdata.result.id;
      userName = resdata.result.userName;
      userMailId = resdata.result.email;
      userMobile = resdata.result.mobile;
      userToken = resdata.result.token;
      userImage = resdata.result.image;
      userAvailableGold = resdata.result.goldWallet;
      userAvailableAmount = resdata.result.amountWallet;
      referalCode = resdata.result.referralCode;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage()));
    } else {
      const snackbar = SnackBar(
        content: Text("Signning up failed"),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  void initState() {
    super.initState();
    getValidationData().whenComplete(() async {
      Timer(
          Duration(seconds: 3),
              () {
            if(savedUid!=null){
              getUserProfileData();
              var country_code=locale.toString().split('_')[1].toString();
              var lang_code=locale.toString().split('_')[0].toString();
              Get.updateLocale(Locale(lang_code,country_code));
            }
            else{
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
            }

          });
      // SignIn()
    });
  }

  Future getValidationData() async{
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    savedUid  = sharedPreferences.getString('UserId');
    locale= sharedPreferences.getString('language');
    print('language is....${locale}');
    print("userId is $savedUid");
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Image.asset("assets/images/LogoSplash.png"),
        ),
      ),
    );
  }
}
