import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/TermsConditionsModel.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';

class PrivacyNotice extends StatefulWidget {
  const PrivacyNotice({Key? key}) : super(key: key);

  @override
  State<PrivacyNotice> createState() => _PrivacyNoticeState();
}

class _PrivacyNoticeState extends State<PrivacyNotice> {
  getPrivacyNotice() async {
    var res = await Webservices.getMap("$baseUrl$get_privacy_policy");
    print("status from api ${res}");
    final resdata = TermsConditionModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      privacyResult = resdata.result;
      setState(() {});
    } else {}
  }

  @override
  void initState() {
    if (privacyResult == null) {
      getPrivacyNotice();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: "Privacy".tr),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: privacyResult == null
            ? Align(
                alignment: Alignment.topCenter,
                child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: ParagraphText(
                  text:privacyResult!.content,
                  textAlign: TextAlign.justify,
                ),
              ),
      ),
    );
  }
}
