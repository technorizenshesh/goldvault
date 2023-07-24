import 'package:flutter/material.dart';
import 'package:goldvault/Screens/ChatDetailScreen.dart';
import 'package:goldvault/Screens/FAQ.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';
import 'package:url_launcher/url_launcher.dart';

class GetSupport extends StatefulWidget {
  const GetSupport({Key? key}) : super(key: key);

  @override
  State<GetSupport> createState() => _GetSupportState();
}

class _GetSupportState extends State<GetSupport> {
  _launchEmail() async {
    launch(
        "mailto:info@goldvault.sk");
  }
  _launchMobile() async {
    launch(
        "tel:+421 940 935 404");
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(context: context,title: "Get Support"),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20,20,25,20),
        child: Column(
          children: [
            ListTile(leading: Image.asset('assets/images/FAQImg.png'),
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FAQ()));
            },
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubHeadingText(
                  text: 'Read our FAQ',
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                ParagraphText(
                  text: 'Looking for more information? Check out our FAQs!',fontSize: 16,
                )
              ],
            ),
            ),
            SizedBox(height: height*0.05,),
            ListTile(leading: Image.asset('assets/images/ChatImg.png'),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatDetailScreen()));
              },
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubHeadingText(
                    text: 'Chat with us',
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  ParagraphText(
                    text: 'Got questions or suggestions? Come say hello!',fontSize: 16,
                  )
                ],
              ),
            ),
            SizedBox(height: height*0.05,),
            ListTile(leading: Image.asset('assets/images/GmailImg.png'),
              onTap: () {
                _launchEmail();
              },
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubHeadingText(
                    text: 'Email us',
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  ParagraphText(
                    text: "info@goldvault.sk We'll reply shortly",fontSize: 16,
                  )
                ],
              ),
            ),
            SizedBox(height: height*0.05,),
            ListTile(leading: Image.asset('assets/images/CallImg.png'),
              onTap: () {
               _launchMobile();
              },
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubHeadingText(
                    text: 'Call us',
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  ParagraphText(
                    text: "Monday - Friday, 9am - 6pm (excluding public holidays)",fontSize: 16,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
