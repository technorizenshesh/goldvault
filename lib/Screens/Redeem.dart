import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/BuyGoldListModel.dart';
import 'package:goldvault/Models/GetGoldListModel.dart';
import 'package:goldvault/Screens/ChooseGold.dart';
import 'package:goldvault/Screens/MapScreen.dart';
import 'package:goldvault/Screens/OrderReview.dart';
import 'package:goldvault/Screens/SellGold.dart';
import 'package:goldvault/Screens/WithdrawCash.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomButton.dart';
import 'package:goldvault/Widgets/CustomSnackBar.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';

class Redeem extends StatefulWidget {
  const Redeem({Key? key}) : super(key: key);

  @override
  State<Redeem> createState() => _RedeemState();
}

class _RedeemState extends State<Redeem> {
  List<BuyGoldListModelResult> redeemGoldList = [];
  int i=0;
bool forwardIconVisibility = true;
bool backwardIconVisibility = false;
  getReedeemGoldList() async {
    Map<String, dynamic> data = {
      "user_id": userId,
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$get_buy_gold_type", body: data, context: context);
    print("status from api ${res}");
    final resdata = BuyGoldListModel.fromJson(res);
    if (resdata.status == '1') {
      redeemGoldList = resdata.result;
      setState(() {});
    } else {}
  }

  @override
  void initState() {
    getReedeemGoldList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(context: context, title: "Redeem"),
      body: Container(
        width: width,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Container(
                    width: width,
                    height: height,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              if(i>0){
                                i--;
                                forwardIconVisibility =true;
                                setState(() {
                                });
                              }
                              else{
                                backwardIconVisibility = false;
                                setState(() {

                                });
                              }
                            },
                            child: Visibility(visible: backwardIconVisibility,
                                child: SvgPicture.asset('assets/images/LeftArrowIcon.svg')),
                          ),

                          redeemGoldList.isEmpty?CircularProgressIndicator():
                          Container(
                              height: height * 0.25,
                              width: width * 0.3,
                              child: Image.network(redeemGoldList[i].frontImage)),
                          InkWell(
                              onTap: (){
                                backwardIconVisibility =true;
                                if(i<redeemGoldList.length-1){
                                  i++;
                                  setState(() {
                                  });
                                }
                                else{
                                  forwardIconVisibility = false;
                                  setState(() {
                                    
                                  });
                                }
                              },
                              child: Visibility(
                                  visible: forwardIconVisibility,
                                  child: SvgPicture.asset('assets/images/RightArrowIcon.svg'))),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      width: width - 40,
                      child: Row(
                        children: [
                          CustomButton(
                            text: "REDEEM",
                            width: width * 0.7,
                            onTap: () {
                              redeemGoldList.isEmpty?showSnackbar(context,'Select Gold'):
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MapScreen(selectedGold: redeemGoldList[i],)));
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
                              height: height * 0.06,
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChooseGold()));
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/BuyGoldLogo.svg'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          AppBarHeadingText(
                            text: "Buy Gold",
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
                                builder: (context) => SellGold()));
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/BuyGoldLogo.svg'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          AppBarHeadingText(
                            text: "Sell Gold",
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
                          SvgPicture.asset(
                              'assets/images/WithdrawCashIcon.svg'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          AppBarHeadingText(
                            text: "Withdraw Cash",
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
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => OrderReview()));
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/RedeemGoldIcon.svg'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          AppBarHeadingText(
                            text: "Redeem Gold",
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
