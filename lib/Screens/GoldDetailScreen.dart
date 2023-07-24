import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goldvault/Constants/ColorConstant.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';

class GoldDetailScreen extends StatefulWidget {
  const GoldDetailScreen({Key? key}) : super(key: key);

  @override
  State<GoldDetailScreen> createState() => _GoldDetailScreenState();
}

class _GoldDetailScreenState extends State<GoldDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(context: context, title: "Suisse Fine Gold"),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.03,
            ),
            Container(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset("assets/images/LeftArrowIcon.svg"),
                  Image.asset("assets/images/GoldBuiscuitImg.png"),
                  SvgPicture.asset("assets/images/RightArrowIcon.svg"),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            Container(
              width: width,
              height: height * 0.2,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: SubHeadingText(text: "Jenis:")),
                        Expanded(
                          flex: 6,
                          child: SubHeadingText(
                              text: "Emas 999.9",
                              color: ColorConstant.bluegreenColor),
                        ),
                      ],
                    ),
                Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: SubHeadingText(text: "Berat:")),
                    Expanded(
                      flex: 6,
                      child: SubHeadingText(
                          text: "10 g",
                          color: ColorConstant.bluegreenColor),
                    ),
                  ],
                ), Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: SubHeadingText(text: "Ketebalan:")),
                        Expanded(
                          flex: 6,
                          child: SubHeadingText(
                              text: "1.25mm",
                              color: ColorConstant.bluegreenColor),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: SubHeadingText(text: "Saiz:")),
                        Expanded(
                          flex: 6,
                          child: SubHeadingText(
                              text: "15.8mm x 26.5mm",
                              color: ColorConstant.bluegreenColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
