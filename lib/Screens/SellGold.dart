import 'package:flutter/material.dart';
import 'package:goldvault/Constants/ColorConstant.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/RequestSellModel.dart';
import 'package:goldvault/Models/SellCalculationModel.dart';
import 'package:goldvault/Models/SellGoldFractionModel.dart';
import 'package:goldvault/Screens/ConfirmationSellGold.dart';
import 'package:goldvault/Screens/OtpVerification.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomLoader.dart';
import 'package:goldvault/Widgets/CustomTextField.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';

class SellGold extends StatefulWidget {
  const SellGold({Key? key}) : super(key: key);

  @override
  State<SellGold> createState() => _SellGoldState();
}

class _SellGoldState extends State<SellGold> {
  TextEditingController amountController = TextEditingController();

  var selectedSellFractionId, selectedSellFraction;
  String selectedPrice = "0.00", selectedWeight = "0.000" ;
  bool loader=false;

  List<SellCalculationResult> sellCalculationResult = [];
  RequestSellResult? requestSellResult;

  getSellFraction() async {
    var res = await Webservices.getMap("$baseUrl$sell_purchase");
    print("status from api ${res}");
    final resdata = SellGoldFractionModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      sellGoldFractionResult = resdata.result;
      setState(() {});
    } else {}
  }

  sellCalculation() async {
    print("selectedSellFraction is......$selectedSellFraction");
    Map<String, dynamic> data = {
      "user_id": userId,
      "sell_purchase": selectedSellFraction,
    };
    setState(() {
      loader=true;
    });
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$get_sell_calculation", body: data, context: context);
    print("status from api ${res}");
    final resdata = SellCalculationModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      loader=false;
      sellCalculationResult = resdata.result;
      selectedPrice = sellCalculationResult[0].amountSell;
      selectedWeight = sellCalculationResult[0].goldSell;
      setState(() {});
    } else {
      setState(() {
        loader=false;
      });
    }
  }
  confirmSellGold() async {

    Map<String, dynamic> data = {
      "user_id": userId,
      "gold_sell": selectedWeight,
      "amount": selectedPrice,
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$add_sell", body: data, context: context);
    print("status from api ${res}");
    final resdata = RequestSellModel.fromJson(res);
    if (resdata.status == '1') {
      requestSellResult = resdata.result;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmationSellGold(sellVerificationId: requestSellResult!.id,)));
      setState(() {});
    } else {
    }
  }

  @override
  void initState() {
    if (sellGoldFractionResult.isEmpty) {
      getSellFraction();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(context: context, title: "Sell Gold"),
      body: SingleChildScrollView(
        child: Container(
          height: height * 0.87,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ParagraphText(text: 'Available gold:'),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          SubHeadingText(
                            text: "$userAvailableGold g",
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    loader?Padding(padding: EdgeInsets.symmetric(vertical: 15),
                    child: CustomLoader(color: ColorConstant.buttonColor,)):
                    Column(
                      children: [
                        ParagraphText(
                          text: '$selectedPrice €',
                          fontSize: 20,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        ParagraphText(text: '$selectedWeight g'),
                      ],
                    ),
                    SizedBox(height: height * 0.05),
                    Container(
                      width: width * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 0;
                              i < sellGoldFractionResult.length;
                              i++)
                            InkWell(
                              onTap: () {
                                selectedSellFractionId =
                                    sellGoldFractionResult[i].id;
                                selectedSellFraction = sellGoldFractionResult[i].percentage;
                                sellCalculation();
                                setState(() {
                                });
                              },
                              child: Container(
                                width: width * 0.2,
                                height: height * 0.05,
                                decoration:BoxDecoration(
                                    color: selectedSellFractionId ==
                                        sellGoldFractionResult[i]
                                            .id
                                        ? ColorConstant.buttonColor
                                        : Colors.transparent,
                                    border: Border.all(
                                        color: Colors.black12),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5))),
                                child: Center(
                                  child: ParagraphText(
                                      text: sellGoldFractionResult[i].name),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubHeadingText(
                          text: "You will get :",
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
                      height: height * 0.2,
                    ),
                    SubHeadingText(
                      text: "Rates update automatically",
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SubHeadingText(
                        text:
                            "Current Gold Price:${goldPriceResult!.price}  € /g Gold value estimated based on the latest price",
                        textAlign: TextAlign.center,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: InkWell(
                    onTap: () {
                      loader?"":
                      _showDialog(context);
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
                              'SELL NOW',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              loader?'calculating....':
                              '€ $selectedPrice',
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

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Sell Gold?",
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text("You are selling $selectedWeight g for $selectedPrice €"),
          actions: <Widget>[
            TextButton(
              child: new Text("No",
                  style: TextStyle(
                      color: ColorConstant.buttonColor,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes",
                  style: TextStyle(
                      color: ColorConstant.buttonColor,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                confirmSellGold();
              },
            ),
          ],
        );
      },
    );
  }
}
