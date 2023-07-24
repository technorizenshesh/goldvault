import 'package:flutter/material.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/GetGoldListModel.dart';
import 'package:goldvault/Screens/BuyGold.dart';
import 'package:goldvault/Screens/GoldDetailScreen.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomButton.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';

class ChooseGold extends StatefulWidget {
  const ChooseGold({Key? key}) : super(key: key);

  @override
  State<ChooseGold> createState() => _ChooseGoldState();
}

class _ChooseGoldState extends State<ChooseGold> {
  List GoldList = [
    {
      "frontImage": "assets/images/GoldBuis.jpg",
      "backImage": "assets/images/GoldBuisBack.jpg"
    },
    {
      "frontImage": "assets/images/GoldBuis.jpg",
      "backImage": "assets/images/GolsBuiscuit1OunceSuisse.jpg"
    },
    {
      "frontImage": "assets/images/GoldBuis1.jpg",
      "backImage": "assets/images/GoldBuis1Back.jpg"
    },
    {
      "frontImage": "assets/images/GoldBuis1.jpg",
      "backImage": "assets/images/GoldBuiscuit1Ounce.jpg"
    },
    {
      "frontImage": "assets/images/GoldCoin50Euro.jpg",
      "backImage": "assets/images/GoldCoinBack.jpg"
    },
    {
      "frontImage": "assets/images/GoldCoinFront.jpg",
      "backImage": "assets/images/GoldCoinBack.jpg"
    },
    {
      "frontImage": "assets/images/GoldCoin1Front.jpg",
      "backImage": "assets/images/GoldCoin1Back.jpg"
    },
    {
      "frontImage": "assets/images/GoldCoin1Front.jpg",
      "backImage": "assets/images/GoldCoin50Dollors.jpg"
    },
  ];

  getGoldMethod() async {
    var res = await Webservices.getMap("$baseUrl$get_gold");
    print("status from api ${res}");
    final resdata = GetGoldListModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      goldListResult = resdata.result;
      setState(() {
      });
    } else {}
  }

  @override
  void initState() {
    if(goldListResult.isEmpty){
      getGoldMethod();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(context: context, title: "Choose Gold"),
      body: Padding(
        padding: EdgeInsets.all(20),
        child:
        goldListResult.isEmpty?Align(
            alignment: Alignment.topCenter,
            child: CircularProgressIndicator()):
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.03,
              ),
                for (int i = 0; i < goldListResult.length; i++)
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    width: width,
                    // height: height*0.25,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                      child: Container(
                        width: width,
                        margin: EdgeInsets.only(left: 36),
                        child: ExpansionTile(
                          trailing: null,
                          iconColor: Colors.transparent,
                          collapsedIconColor: Colors.transparent,
                          title: Container(
                            height: height * 0.15,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(goldListResult[i].frontImage),
                                  SizedBox(
                                    width: width * 0.05,
                                  ),
                                  Image.network(goldListResult[i].backImage),
                                ],
                              ),
                            ),
                          ),
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Container(width: width*0.2,
                               child:
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     ParagraphText(text: 'Brand     :',color: Colors.black,fontSize: 18,),
                                     SizedBox(height: 0.02,),
                                     ParagraphText(text: 'Purity     :',color: Colors.black,fontSize: 18,),
                                     SizedBox(height: 0.02,),
                                     ParagraphText(text: 'Weight   :',color: Colors.black,fontSize: 18,),
                                     SizedBox(height: 0.02,),
                                     ParagraphText(text: 'Size        :',color: Colors.black,fontSize: 18,),
                                   ],
                                 ),
                               ),
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   ParagraphText(text: goldListResult[i].brand,color: Colors.black,fontSize: 18,),
                                   SizedBox(height: 0.02,),
                                   ParagraphText(text: goldListResult[i].purity,color: Colors.black,fontSize: 18,),
                                   SizedBox(height: 0.02,),
                                   ParagraphText(text: goldListResult[i].weight,color: Colors.black,fontSize: 18,),
                                   SizedBox(height: 0.02,),
                                   ParagraphText(text:goldListResult[i].size,color: Colors.black,fontSize: 18,),
                                 ],
                               ),
                             ], 
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(24),
                              child: CustomButton(
                                text: 'Add',
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BuyGold(goldTypeId: goldListResult[i].id,)));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

              // InkWell(
              //   onTap: (){
              //     setState(() {
              //       // isAdd=!isAdd;
              //     });
              //   },
              //   child: Container(
              //     width: width,
              //     height: height*0.17,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       border:Border.all(color: Colors.black12),
              //       borderRadius: BorderRadius.all(Radius.circular(20))
              //     ),
              //     child: Column(
              //       children: [
              //         Container(
              //           height: height*0.10,
              //           width: width,
              //           child: Padding(
              //             padding: EdgeInsets.all(10),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Image.asset("assets/images/GoldBuis.jpg"),
              //                 SizedBox(width: width*0.05,),
              //                 Image.asset("assets/images/GoldBuisBack.jpg"),
              //               ],
              //             ),
              //           ),
              //         ),
              //         // if(isAdd)
              //         // Text('add')
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(height: height*0.05,),
              // Container(
              //   width: width,
              //   height: height*0.17,
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       border:Border.all(color: Colors.black12),
              //       borderRadius: BorderRadius.all(Radius.circular(20))
              //   ),
              //   child: Padding(
              //     padding: EdgeInsets.all(10),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Image.asset("assets/images/GoldCoinFront.jpg"),
              //         SizedBox(width: width*0.03,),
              //         Image.asset("assets/images/GoldCoinBack.jpg"),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(height: height*0.05,),
              // Container(
              //   width: width,
              //   height: height*0.17,
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       border:Border.all(color: Colors.black12),
              //       borderRadius: BorderRadius.all(Radius.circular(20))
              //   ),
              //   child: Padding(
              //     padding: EdgeInsets.all(10),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Image.asset("assets/images/GoldCoin1Back.jpg"),
              //         SizedBox(width: width*0.03,),
              //         Image.asset("assets/images/GoldCoin1Front.jpg"),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
