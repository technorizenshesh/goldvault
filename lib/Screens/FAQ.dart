import 'package:flutter/material.dart';
import 'package:goldvault/Constants/ColorConstant.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/FAQModel.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {

  getFAQs() async {
    var res = await Webservices.getMap("$baseUrl$get_faq");
    print("status from api ${res}");
    final resdata = FAQModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      faqResult = resdata.result;
      setState(() {
      });
    } else {}
  }


  @override
  void initState() {
    if(faqResult.isEmpty){
      getFAQs();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(context: context, title: "FAQ"),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          children: [
            Center(
                child: Image.asset(
              "assets/images/FAQImage.png",
              height: height * 0.15,
            )),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      for (int i = 0; i < faqResult.length; i++)
                        ExpansionTile(
                          initiallyExpanded: false,
                          collapsedTextColor: Colors.black,
                          textColor: Colors.black,
                          iconColor: ColorConstant.buttonColor,
                          collapsedIconColor: ColorConstant.buttonColor,
                          title: Text(
                            faqResult[i].question,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17 ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(faqResult[i].answer,style: TextStyle(
                                  fontSize: 16
                              ),),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
