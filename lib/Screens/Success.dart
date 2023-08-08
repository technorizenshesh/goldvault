import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goldvault/Screens/HomeTab.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomButton.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';

class Success extends StatefulWidget {
  final String weight;
  final String type;

  const Success({Key? key, required this.weight, required this.type})
      : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/SuccessIcon.svg'),
                      SizedBox(
                        height: 0.2,
                      ),
                      MainHeadingText(text: 'Success!'.tr),
                      SizedBox(
                        height: 0.2,
                      ),
                      SubHeadingText(
                          text: widget.type == "Buy".tr
                              ? "You successfully bought ${widget.weight} of gold".tr
                              : widget.type == "Sell"
                                  ? "You successfully sold ${widget.weight} of gold".tr
                                  : widget.type == "Withdraw".tr
                                      ? "You have successfully requested for withdrawn of ${widget.weight} € amount".tr
                                      : widget.type == "Redeem"?"You have successfully requested for Redeem gold of ${widget.weight}g":"")
                    ],
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      child: CustomButton(
                        text: "RETURN TO HOME".tr,
                        width: width - 40,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeTab()));
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
