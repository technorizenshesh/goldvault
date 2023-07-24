import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goldvault/Constants/ColorConstant.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Widgets/CustomSnackBar.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';

class EnterCode extends StatefulWidget {
  const EnterCode({Key? key}) : super(key: key);

  @override
  State<EnterCode> createState() => _EnterCodeState();
}

class _EnterCodeState extends State<EnterCode> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            SvgPicture.asset('assets/images/CodeIcon.svg'),
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ParagraphText(
                text:
                'Get 5 € worth of gold when your friend uses your referral code and buy gold worth 50 €! How it works',
                fontSize: 16,
                textAlign: TextAlign.center,),
            ),
            SizedBox(height: height * 0.05,),
            Container(
              width: width,
              height: height * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12),
              ),
              child: Row(
                children: [
                  Container(
                    width:width*0.64,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ParagraphText(
                            text:
                            referalCode, fontSize: 18),
                          InkWell(
                              onTap: (){
                                Clipboard.setData(ClipboardData(text: referalCode)).then((value) => showSnackbar(context, "code copied" ));
                              },
                              child: SvgPicture.asset('assets/images/CopyIcon.svg'))
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      share();
                    },
                    child: Container(
                      width: width * 0.25,
                      height: height * 0.07,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black12),
                        color: ColorConstant.lightGreen1,
                      ),
                      child: Center(
                        child: ParagraphText(
                          text:
                          'SHARE',color: Colors.white, fontSize: 18, textAlign: TextAlign.center,),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            ParagraphText(
              text:
              "You've received a bonus of 0.00 € as 0 of your friends have used your code!",
              fontSize: 16,
              textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
  Future<void> share() async {
    print("object...");
    await FlutterShare.share(
        title: 'Code share',
        text: referalCode,
        linkUrl: 'https://play.google.com/store/apps/details',
       // chooserTitle: 'Example Chooser Title'
    );
  }
}
