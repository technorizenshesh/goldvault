import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goldvault/Constants/ColorConstant.dart';
import 'package:goldvault/Screens/BuyGold.dart';
import 'package:goldvault/Screens/ChooseGold.dart';
import 'package:goldvault/Screens/ConfirmationSellGold.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomButton.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';

class MyGold extends StatefulWidget {
  const MyGold({Key? key}) : super(key: key);

  @override
  State<MyGold> createState() => _MyGoldState();
}

class _MyGoldState extends State<MyGold> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(context: context, title: "My Gold"),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Center(
                  child: Container(
                    width: width * 0.35,
                    child: Column(
                      children: [
                        Image.asset('assets/images/GoldBuisBack.jpg'),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        SubHeadingText(
                          text: '0.059 g',
                          fontSize: 20,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          children: [
                            ParagraphText(text: "Cash Balance: "),
                            SubHeadingText(
                              text: '0.22 €',
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ParagraphText(
                      text: "My total gold value: ",
                      fontSize: 18,
                    ),
                    AppBarHeadingText(
                      text: "15.54 €",
                      fontSize: 20,
                      color: Colors.red,
                    )
                  ],
                )
              ],
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: width,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        text: "BUY GOLD",
                        width: width * 0.7,
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => BuyGold()));
                        },
                      ),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      SvgPicture.asset("assets/images/MoreButton.svg",height:height*0.06,)
                    ],
                  ),
                ))
          ],
        ),

      ),
    );
  }
}
