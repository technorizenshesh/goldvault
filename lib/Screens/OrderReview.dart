import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:goldvault/Constants/ColorConstant.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/AddRedeemModel.dart';
import 'package:goldvault/Models/BuyGoldListModel.dart';
import 'package:goldvault/Screens/MapScreen.dart';
import 'package:goldvault/Screens/Success.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomButton.dart';
import 'package:goldvault/Widgets/CustomSnackBar.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';

class OrderReview extends StatefulWidget {
  final BuyGoldListModelResult selectedGold;
  const OrderReview({Key? key, required this.selectedGold}) : super(key: key);

  @override
  State<OrderReview> createState() => _OrderReviewState();
}

class _OrderReviewState extends State<OrderReview> {
 // Position? _currentPosition;

  // @override
  // void initState() {
  //   getValidationData();
  //   super.initState();
  // }
 //   getValidationData() async {
 //    await _getCurrentLocation();
 //    getAddress();
 //  }
 // getAddress() async {
 //    try {
 //      List<Placemark> placemarks = await placemarkFromCoordinates(currentLat, currentLon);
 //      if (placemarks != null && placemarks.isNotEmpty) {
 //        Placemark placemark = placemarks[0];
 //        currentAddress = '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}, ${placemark.postalCode}';
 //      setState(() {
 //
 //      });
 //      }
 //    } catch (e) {
 //      print('Error: $e');
 //    }
 //  }
 //  Future<Position> _getCurrentLocation() async {
 //    bool isPermissionGranted = await requestPermission();
 //    print(isPermissionGranted);
 //    if (isPermissionGranted) {
 //      // setState(() async{
 //      _currentPosition = await Geolocator.getCurrentPosition();
 //      currentLat = _currentPosition!.latitude;
 //      currentLon = _currentPosition!.longitude;
 //      return _currentPosition!;
 //    } else {
 //      throw requestPermission();    }
 //  }
 //
 //  Future<bool> requestPermission() async {
 //    LocationPermission permission = await Geolocator.requestPermission();
 //    if (permission == LocationPermission.denied) {
 //      permission = await Geolocator.requestPermission();
 //      if (permission == LocationPermission.denied) {
 //        return false;
 //      }
 //    }
 //    return true;
 //  }

  redeemGold() async {
    Map<String, dynamic> data = {
      "user_id": userId,
      "gold_id":widget.selectedGold.goldId,
      "amount":widget.selectedGold.amount
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$add_redeem", body: data, context: context);
    print("status from api ${res}");
    final resdata = AddRedeemModel.fromJson(res);
    if (resdata.status == '1') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Success(weight:"10", type: 'Redeem',)));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(context: context, title: 'Order Review'.tr),
      body: Container(
        width: width,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            child: Stack(
              children: [
                Container(
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width,
                        height: height * 0.15,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Image.network(widget.selectedGold.frontImage),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ParagraphText(
                                      text: "Emas 999.9",
                                      color: ColorConstant.bluegreenColor),
                                  ParagraphText(
                                      text: "10 g",
                                      color: ColorConstant.bluegreenColor),
                                  ParagraphText(
                                      text: "1.25mm",
                                      color: ColorConstant.bluegreenColor),
                                  ParagraphText(
                                      text: "15.8mm x 26.5mm",
                                      color: ColorConstant.bluegreenColor),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      SubHeadingText(text: 'Address'.tr),
                      SizedBox(height: height*0.03,),
                      currentAddress==null?Center(child: CircularProgressIndicator()):
                      Container(
                          width: width,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                              padding:EdgeInsets.all(20),child: ParagraphText(text:currentAddress,fontSize: 20,))),
                      // Container(
                      //   width: width,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       SizedBox(height: height*0.05,),
                      //       ParagraphText(text: 'Rex jod'),
                      //       SizedBox(height: height*0.03,),
                      //       ParagraphText(text: 'agreeeesen aquer'),
                      //       SizedBox(height: height*0.03,),
                      //       ParagraphText(text: 'Besni/Adiyaman')
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      child: CustomButton(
                        text: "COMPLETE ORDER".tr,
                        width: width - 40,
                        onTap: () {
                          redeemGold();
                        },
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
