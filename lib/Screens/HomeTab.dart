import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Models/GetGoldPriceModel.dart';
import 'package:goldvault/Screens/BuyGold.dart';
import 'package:goldvault/Screens/ChooseGold.dart';
import 'package:goldvault/Screens/GetSupport.dart';
import 'package:goldvault/Screens/GoldPriceChart.dart';
import 'package:goldvault/Screens/MyGold.dart';
import 'package:goldvault/Screens/Redeem.dart';
import 'package:goldvault/Screens/Rewards.dart';
import 'package:goldvault/Screens/SellGold.dart';
import 'package:goldvault/Screens/WithdrawCash.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomButton.dart';
import 'package:goldvault/Widgets/CustomSnackBar.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';
import 'package:flutter/material.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/GetNewsAndTipsModel.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Models/GetGoldPriceModel.dart';
import 'package:intl/intl.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  getGoldRate() async {

    var res = await Webservices.getMap("$baseUrl$current_price_gold");
    print("status from api ${res}");
    final resdata = GetGoldPriceModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      goldPriceResult = resdata.result;
      setState(() {
      });
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  getNewsAndTips() async {
    var res = await Webservices.getMap("$baseUrl$get_new_and_tips");
    print("status from api ${res}");
    final resdata = GetNewsAndTipsModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      getNewsAndTipsResult = resdata.result;
      setState(() {
      });
    } else {

    }
  }

  @override
  void initState() {
    if(getNewsAndTipsResult.isEmpty){
      getNewsAndTips();
    }
    if(goldPriceResult==null){
      getGoldRate();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Container(
          width: width * 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/VaultLogo.png",
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Goldvault".tr,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: SvgPicture.asset("assets/images/BellIcon.svg"))
        ],
      ),
      body: Column(
        children: [
          Center(child: Text('Hello, $userName'.tr)),
          SizedBox(
            height: height * 0.02,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 3, 20, 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyGold()));
                      },
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Image.asset('assets/images/StarImg.png'),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            SubHeadingText(
                              text: 'My Gold'.tr,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            SubHeadingText(
                              text: "${userAvailableGold} g",
                              fontSize: 20,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ParagraphText(text: "Cash Balance: ".tr),
                                SubHeadingText(
                                  text: '${userAvailableAmount} €',
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppBarHeadingText(
                            text: "Price per gram".tr,
                            fontSize: 18,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          ParagraphText(
                              text: goldPriceResult==null?"":"Last updated ${DateFormat('hh:mm a').format(goldPriceResult!.date)}")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppBarHeadingText(
                          text: "Gold".tr,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ParagraphText(text: "Buy".tr),
                            SizedBox(
                              height: 0.01,
                            ),
                            AppBarHeadingText(
                              text: "274.39 €",
                              fontSize: 18,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ParagraphText(text: "Sell".tr),
                            SizedBox(
                              height: 0.01,
                            ),
                            AppBarHeadingText(
                              text: "262.02 €",
                              fontSize: 18,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.08,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GoldPriceChart()));
                      },
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width*0.4,
                                child: Row(
                                  children: [
                                    Image.asset('assets/images/GoldBarImg.png'),
                                    SizedBox(
                                      width: width * 0.03,
                                    ),
                                    AppBarHeadingText(
                                      text: "Gold Price Chart".tr,
                                      fontSize: 17,
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                width: width*0.3,
                                  child: SvgPicture.asset('assets/images/GraphIcon.svg',fit: BoxFit.fill
                                    ,))
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Container(
                      width: width,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            text: "BUY GOLD".tr,
                            width: width * 0.7,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChooseGold()));
                            },
                          ),
                          SizedBox(
                            width: width * 0.05,
                          ),
                          InkWell(
                            onTap: () {
                              showSheet();
                            },
                            child: SvgPicture.asset(
                              "assets/images/MoreButton.svg",
                              height: height*0.06,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppBarHeadingText(
                        text: "Smart Saver".tr,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius:
                          BorderRadius.all(Radius.circular(15))),
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/StarImg.png'),
                            SizedBox(
                              width: width * 0.05,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppBarHeadingText(
                                  text: "Start your first goal?".tr,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Container(
                                    width: width * 0.6,
                                    child: ParagraphText(
                                        text:
                                            "Set a goal, fund every month, save every time!".tr)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppBarHeadingText(
                        text: "News And Tips".tr,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < getNewsAndTipsResult.length; i++)
                            Row(
                              children: [
                                Container(
                                  width: width * 0.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height:height*0.15,
                                        width: width * 0.5,
                                          decoration: BoxDecoration(
                                            //  border: Border.all(color: Colors.black12),
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(15))),
                                          child: Image.network(getNewsAndTipsResult[i].image)
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      AppBarHeadingText(
                                        text: getNewsAndTipsResult[i].content,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                )
                              ],
                            )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius:
                          BorderRadius.all(Radius.circular(15))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            AppBarHeadingText(
                              text: "Free Gold".tr,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 50, right: 50),
                                child: Text(
                                  'Invite your friends to HelloGold and receive free gold!'.tr,
                                  style: TextStyle(),
                                  textAlign: TextAlign.center,
                                )),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            CustomButton(
                              text: "INVITE FRIENDS".tr,
                              height: height * 0.05,
                              width: width * 0.4,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Rewards()));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    CustomButton(
                      text: "GET SUPPORT".tr,
                      width: width,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GetSupport()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ChooseGold()));
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/BuyGoldLogo.svg'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          AppBarHeadingText(
                            text: "Buy Gold".tr,
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SellGold()));
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/BuyGoldLogo.svg'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          AppBarHeadingText(
                            text: "Sell Gold".tr,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WithdrawCash()));
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/WithdrawCashIcon.svg'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          AppBarHeadingText(
                            text: "Withdraw Cash".tr,
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Redeem()));
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/RedeemGoldIcon.svg'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          AppBarHeadingText(
                            text: "Redeem Gold".tr,
                            fontSize: 18,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
