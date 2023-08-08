import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldvault/Constants/ColorConstant.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/WithdrawCashModel.dart';
import 'package:goldvault/Screens/Success.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomSnackBar.dart';
import 'package:goldvault/Widgets/CustomTextField.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';

class WithdrawCash extends StatefulWidget {
  const WithdrawCash({Key? key}) : super(key: key);

  @override
  State<WithdrawCash> createState() => _WithdrawCashState();
}

class _WithdrawCashState extends State<WithdrawCash> {

  WithdrawCashResult? withdrawCashResult;

  withdrawCash() async {

    Map<String, dynamic> data = {
      "user_id": userId,
      "amount": amountController.text,
      "account_number": bankNumberController.text,
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$add_withdrawal_payment", body: data, context: context);
    print("status from api ${res}");
    final resdata = WithdrawCashModel.fromJson(res);
    if (resdata.status == '1') {
      withdrawCashResult = resdata.result;
      userAvailableAmount = withdrawCashResult!.amountWallet;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Success(weight:amountController.text, type: 'Withdraw',)));
      setState(() {});
    } else {
    }
  }

  TextEditingController amountController = TextEditingController();
  TextEditingController bankNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(context: context, title: "Withdraw Cash".tr),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ParagraphText(text: 'Cash Balance: '.tr),
                          SubHeadingText(
                            text: "${userAvailableAmount} €",
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.05,),
                    ParagraphText(text: amountController.text.isEmpty?'€ 0.00':
                    '€ ${amountController.text}', fontSize: 20,),
                    // SizedBox(height: height * 0.01,),
                    // ParagraphText(text: '0.000 g'),
                    SizedBox(height: height * 0.1,),
                    CustomTextField(
                      controller: amountController,
                      hintText: "Enter Amount".tr,
                      errormsg: 'Enter Amount'.tr,
                      keyboardType:TextInputType.number,
                      borderColor: Colors.black12,
                      borderradius: 10,
                    ),
                    SizedBox(height: height*0.03,),
                    CustomTextField(
                      controller: bankNumberController,
                      hintText: "Bank Number".tr,
                      errormsg: 'Enter Bank Number'.tr,
                      keyboardType:TextInputType.number,
                      borderColor: Colors.black12,
                      borderradius: 10,
                    ),
                    SizedBox(height: height * 0.35,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: MainHeadingText(
                        text: "Your withdrawal request will be processed within 2 working days".tr,
                        textAlign: TextAlign.center,
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: InkWell(
                    onTap: () {
                      if(amountController.text.isEmpty){
                        showSnackbar(context, "please enter amount".tr);
                      }
                      else if(bankNumberController.text.isEmpty){
                        showSnackbar(context, "please enter bank number".tr);
                      }
                      else{
                        withdrawCash();
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
                              'WITHDRAW'.tr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(amountController.text.isEmpty?'€ 0.00':
                              '€ ${amountController.text}',
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
}
