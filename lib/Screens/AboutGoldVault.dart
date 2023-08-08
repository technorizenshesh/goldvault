import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/AboutUsModel.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';

class AboutGoldVault extends StatefulWidget {
  const AboutGoldVault({Key? key}) : super(key: key);

  @override
  State<AboutGoldVault> createState() => _AboutGoldVaultState();
}

class _AboutGoldVaultState extends State<AboutGoldVault> {
  //AboutUsResult? aboutResult;

  getAboutUs() async {
    var res = await Webservices.getMap("$baseUrl$get_about_us");
    print("status from api ${res}");
    final resdata = AboutUsModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      aboutResult = resdata.result;
      setState(() {

      });
    } else {}
  }

  @override
  void initState() {
    if(aboutResult==null){
      getAboutUs();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(context: context, title: "About Gold Vault".tr),
      body: Padding(
        padding: EdgeInsets.all(20),
        child:
            aboutResult==null?Align(
              alignment: Alignment.topCenter,
                child: CircularProgressIndicator()):
        Column(
          children: [
            Container(
                width: width,
                height: height*0.25,
                child: Image.network(
                  aboutResult!.image,
                  fit: BoxFit.fill,
                )),
            SizedBox(
              height: height * 0.03,
            ),
            ParagraphText(
              height: 1.5,
              text:aboutResult!.content,
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
