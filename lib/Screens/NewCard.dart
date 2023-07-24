import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/custom_card_type_icon.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goldvault/Constants/ColorConstant.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/AddCardModel.dart';
import 'package:goldvault/Models/GeneralModel.dart';
import 'package:goldvault/Models/GetCardModel.dart';
import 'package:goldvault/Models/GetPaymentTokenModel.dart';
import 'package:goldvault/Models/StripePaymentModel.dart';
import 'package:goldvault/Screens/Success.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomLoader.dart';
import 'package:goldvault/Widgets/CustomSnackBar.dart';
import 'package:goldvault/Widgets/CustomTextField.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';

class NewCard extends StatefulWidget {
  final String gold_id, amount, weight;

  const NewCard(
      {Key? key,
      required this.gold_id,
      required this.amount,
      required this.weight})
      : super(key: key);

  @override
  State<NewCard> createState() => _NewCardState();
}

class _NewCardState extends State<NewCard> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expDateController = TextEditingController();
  TextEditingController securityCodeController = TextEditingController();
  TextEditingController cardHolderController = TextEditingController();
  bool isRemember = false;
  bool newCard = false;
  bool cardList = true;
  bool rememberCardVisibility = false;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = true;
  OutlineInputBorder? border;
  bool loader=false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String paymentToken = '';

  getCard() async {
    Map<String, dynamic> data = {
      "user_id": userId,
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$get_card", body: data, context: context);
    print("status from api ${res}");
    final resdata = GetCardModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      getCardResult = resdata.result;
      setState(() {});
      print("sucess....");
    } else {
      showSnackbar(context, 'Get card failed');
    }
  }

  addCard() async {
    Map<String, dynamic> data = {
      "user_id": userId,
      "card_number": cardNumber,
      "cvc": cvvCode,
      "card_holder_name": cardHolderName,
      "remember": isRemember == true ? "Yes" : "No",
      "year": expiryDate,
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$add_card", body: data, context: context);
    print("status from api ${res}");
    final resdata = AddCardModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      print("sucess....");
      getCard();
      getPaymentToken();
    } else {
      showSnackbar(context, 'Add card failed');
    }
  }

  deleteCard(String cardId) async {
    Map<String, dynamic> data = {
      "user_id": userId,
      "card_id": cardId,
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$card_delete", body: data, context: context);
    print("status from api ${res}");
    final resdata = GeneralModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      showSnackbar(context, "card deleted successfully");
    } else {
      showSnackbar(context, 'Card deletion failed');
    }
  }

  getPaymentToken() async {
    final splittedDate = expiryDate.split("/");
    print("splittedDate is $splittedDate");
    String expmonth = splittedDate[0];
    String expyear = splittedDate[1];
    print("expmonth....$expmonth");
    print("expyear....$expyear");

    Map<String, dynamic> data = {
      "card_number": cardNumber,
      "expiry_date": expyear,
      "expiry_month": expmonth,
      "cvc_code": cvvCode,
    };
    // setState(() {
    //   loader=true;
    // });
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$get_token", body: data, context: context);

    print("status from api ${res}");
    final resdata = GetPaymentTokenModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      paymentToken = resdata.result.id;
      print("payment token is.....$paymentToken");
      buyGold();
      setState(() {});
      print("sucess....");
    } else {
      showSnackbar(context, 'Get payment token failed');
      setState(() {
        loader=false;
      });
    }
  }

  buyGold() async {
    Map<String, dynamic> data = {
      "user_id": userId,
      "amount": "100",
      "payment_method": "card",
      "gold_id": widget.gold_id,
      "currency": "EUR",
      "gold_purchase": widget.weight,
      "token": paymentToken
    };
    setState(() {
      loader=true;
    });
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$payment", body: data, context: context);
    print("status from api ${res}");
    final resdata = StripePaymentModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Success(weight: widget.weight, type: 'Buy',)));
      print("payment Success....");
    } else {
      showSnackbar(context, 'Payment failed');
      setState(() {
        loader=false;
      });
    }
  }

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    if (getCardResult.isEmpty) {
      getCard();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(context: context, title: 'Card'),
      resizeToAvoidBottomInset: false,
      body:Stack(
        children: [
          addCardContainer(),
          Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: _onValidate,
                child: Container(
                  width: width,
                  height: height * 0.07,
                  color: ColorConstant.buttonColor,
                  child: Center(
                      child: loader?CustomLoader():Text(
                    'CHECK OUT',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ))
        ],
      ),
    );
  }

  addCardContainer() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('assets/bg.png'),
          fit: BoxFit.fill,
        ),
        color: Colors.white,
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            Visibility(
              visible: newCard,
              child: CreditCardWidget(
                glassmorphismConfig:
                    useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                cardBgColor:Colors.white,
                //bankName: 'Axis Bank',
                frontCardBorder:
                    !useGlassMorphism ? Border.all(color: Colors.white) : null,
                backCardBorder:
                    !useGlassMorphism ? Border.all(color: Colors.white) : null,
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                // cardBgColor: ColorConstant.pinkColor,
                backgroundImage:
                    useBackgroundImage ? 'assets/images/cardred.png' : null,
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                customCardTypeIcons: <CustomCardTypeIcon>[
                  CustomCardTypeIcon(
                    cardType: CardType.mastercard,
                    cardImage: Image.asset(
                      'assets/mastercard.png',
                      height: 48,
                      width: 48,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: cardList,
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        cardList = false;
                        newCard = true;
                        rememberCardVisibility = true;
                        setState(() {});
                      },
                      child:
                          SvgPicture.asset('assets/images/AddCardButton.svg')),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < getCardResult.length; i++)
                            GestureDetector(
                              onTap: () async {
                                cardNumber = getCardResult[i].cardNumber;
                                cardHolderName = getCardResult[i].cardHolderName;
                                cvvCode = getCardResult[i].cvc;
                                expiryDate = getCardResult[i].year;

                                cardNumber = getCardResult[i].cardNumber;
                                cardList = false;
                                newCard = true;
                                rememberCardVisibility = false;
                                /// ann
                                print("ccc no -------------${getCardResult[i].cardNumber}   ${cardNumber}");
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Container(
                                  height: 150,
                                  width: 300,
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          // selectedCard['id'] == paymantCard[i]['id']
                                          //     ? "assets/images/Card.png"
                                          //     :
                                          "assets/images/cardred.png"),
                                      fit: BoxFit.contain,
                                    ),
                                    // borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            MainHeadingText(
                                              text:
                                                  "Account Holder \n ${getCardResult[i].cardHolderName}  ",
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            MainHeadingText(
                                              text:
                                                  "************${getCardResult[i].cardNumber.toString().substring(getCardResult[i].cardNumber.toString().length - 4)}",
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                _showDialog(context,getCardResult[i].id,i);
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: newCard,
              child: Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        themeColor: Colors.black,
                        textColor: Colors.black,
                        cardNumberDecoration: InputDecoration(
                          labelText: 'Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                          hintStyle: const TextStyle(color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        expiryDateDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'Expired Date',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'Card Holder',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: rememberCardVisibility,
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: ColorConstant.buttonColor,
                            value: isRemember,
                            onChanged: (bool? value) {
                              setState(() {
                                isRemember = !isRemember;
                              });
                            },
                          ),
                          title: SubHeadingText(
                            text: 'Remember Card',
                            color: isRemember ? Colors.black : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onValidate() {
    if(cardList==true){
      showSnackbar(context, "please select card");
    }
    else if(formKey.currentState!.validate()) {
        if (isRemember == true) {
          addCard();
        } else {
          getPaymentToken();
        }
      // print('valid!');
    } else {
      print('invalid!');
    }
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  void _showDialog(BuildContext context,String cardId,int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
          Text("Delete Card", style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text("Are you sure to delete the card?"),
          actions: <Widget>[
            TextButton(
              child: new Text("No",
                  style: TextStyle(
                      color: ColorConstant.buttonColor, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes",
                  style: TextStyle(
                      color:ColorConstant.buttonColor, fontWeight: FontWeight.bold)),
              onPressed: () {
                deleteCard(cardId);
                Navigator.of(context).pop();
                getCardResult.removeAt(index);
                setState(() {
                });
              },
            ),
          ],
        );
      },
    );
  }
}
