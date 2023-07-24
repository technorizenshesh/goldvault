import 'package:flutter/material.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/TermsConditionsModel.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';

class TermsConditionScreen extends StatefulWidget {
  const TermsConditionScreen({Key? key}) : super(key: key);

  @override
  State<TermsConditionScreen> createState() => _TermsConditionScreenState();
}

class _TermsConditionScreenState extends State<TermsConditionScreen> {
  getTC() async {
    var res = await Webservices.getMap("$baseUrl$get_term_condition");
    print("status from api ${res}");
    final resdata = TermsConditionModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      tcResult = resdata.result;
      setState(() {
      });
    } else {}
  }

  @override
  void initState() {
    if(tcResult==null){
      getTC();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: "Terms and Conditions"),
      body: Padding(
        padding: EdgeInsets.all(20),
        child:
        tcResult==null?Align(
            alignment: Alignment.topCenter,
            child: CircularProgressIndicator()):
        SingleChildScrollView(
          child: ParagraphText(
            text:tcResult!.content,
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
