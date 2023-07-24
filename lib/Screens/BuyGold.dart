import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goldvault/Constants/ColorConstant.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/GetGoldTypeModel.dart';
import 'package:goldvault/Screens/Bank.dart';
import 'package:goldvault/Screens/NewCard.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomSnackBar.dart';
import 'package:goldvault/Widgets/CustomTextField.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';

class BuyGold extends StatefulWidget {
  final String goldTypeId;

  const BuyGold({Key? key, required this.goldTypeId}) : super(key: key);

  @override
  State<BuyGold> createState() => _BuyGoldState();
}

class _BuyGoldState extends State<BuyGold> {
  TextEditingController amountController = TextEditingController();
  String paymentMethod = "Select payment method";
  List<GetGoldTypeResult> selectedGoldListResult = [];
  var selectedGold;
  String selectedPrice = "0.00", selectedWeight = "0.000" ;

  getSelectedGoldList() async {
    Map<String, dynamic> data = {
      "gold_id": widget.goldTypeId,
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$get_gold_type", body: data, context: context);
    print("status from api ${res}");
    final resdata = GetGoldTypeModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      selectedGoldListResult = resdata.result;
      setState(() {});
    } else {
    }
  }

  @override
  void initState() {
    getSelectedGoldList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(context: context, title: "Buy Gold"),
      body: SingleChildScrollView(
        child: Container(
          height: height * 0.87,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ParagraphText(text: 'Current Gold Price:'),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          SubHeadingText(
                            text: "${goldPriceResult!.price} €/g",
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    ParagraphText(
                      text: 'Minimum ammont 10 EUR',
                      fontSize: 16,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    ParagraphText(
                      text: '$selectedPrice €',
                      fontSize: 20,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    ParagraphText(text: '$selectedWeight'),
                    SizedBox(height: height * 0.05),
                    selectedGoldListResult.isEmpty
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: CircularProgressIndicator())
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int i = 0;
                                    i < selectedGoldListResult.length;
                                    i++)
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedGold =
                                                selectedGoldListResult[i].id;
                                            selectedPrice = selectedGoldListResult[i].goldPrice;
                                            selectedWeight = selectedGoldListResult[i].goldInGram;

                                          });
                                        },
                                        child: Container(
                                          width: width * 0.15,
                                          height: height * 0.05,
                                          decoration: BoxDecoration(
                                              color: selectedGold ==
                                                      selectedGoldListResult[i]
                                                          .id
                                                  ? ColorConstant.buttonColor
                                                  : Colors.transparent,
                                              border: Border.all(
                                                  color: Colors.black12),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: Center(
                                            child: ParagraphText(
                                                text:
                                                    '${selectedGoldListResult[i].goldPrice} €'),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.04,
                                      )
                                    ],
                                  )
                              ],
                            ),
                          ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    // CustomTextField(
                    //   controller: amountController,
                    //   hintText: "Enter Amount",
                    //   errormsg: 'Confirm password',
                    //   borderColor: Colors.black12,
                    //   borderradius: 10,
                    // ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        showSheet();
                      },
                      child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SubHeadingText(
                                  text: paymentMethod,
                                  color:
                                      paymentMethod == "Select payment method"
                                          ? Colors.grey
                                          : Colors.black87,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubHeadingText(
                          text: "Gold Purchased:",
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        SubHeadingText(
                          text: "$selectedPrice €",
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.22,
                    ),
                    SubHeadingText(
                      text: "Rates update automatically",
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: InkWell(
                    onTap: () {
                      if(selectedGold==null){
                        showSnackbar(context, 'Please select amount');
                      }
                     else if (paymentMethod == "Bank") {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Bank()));
                      } else if (paymentMethod == "Card") {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => NewCard(gold_id: widget.goldTypeId, amount: selectedPrice, weight: selectedWeight,)));
                      } else {
                        showSnackbar(context, 'Please select payment method');

                      }
                    },
                    child: Container(
                      width: width,
                      height: height * 0.07,
                      color: ColorConstant.buttonColor,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'BUY NOW',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '€ ${selectedPrice} ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
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
            height: MediaQuery.of(context).size.height * 0.3,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Column(
                children: [
                  AppBarHeadingText(
                    text: paymentMethod,
                    fontSize: 18,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        paymentMethod = "Bank";
                        Navigator.pop(context);
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/images/BankLogo.svg'),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppBarHeadingText(
                              text: "Bank",
                              fontSize: 18,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            ParagraphText(text: "Use your cash balance to buy"),
                          ],
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
                      setState(() {
                        paymentMethod = "Card";
                        Navigator.pop(context);
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/images/CardIcon.svg'),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppBarHeadingText(
                              text: "Card",
                              fontSize: 18,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            ParagraphText(
                                text: "We accept VISA and MasterCard"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
