import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goldvault/Constants/ColorConstant.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/HistoryModel.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';
import 'package:intl/intl.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {

  List<HistoryResult> historyResult = [];
  getHistoryDate() async {
    Map<String, dynamic> data = {
      "user_id": userId,
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$get_notification_history", body: data, context: context);
    print("status from api ${res}");
    final resdata = HistoryModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      historyResult = resdata.result;
      setState(() {});
    } else {
    }
  }

  @override
  void initState() {
    getHistoryDate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppBarHeadingText(text: 'History'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            historyResult.isEmpty?Container():
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < historyResult.length; i++)
                      Column(
                        children: [
                          Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CachedNetworkImage(imageUrl: historyResult[i].image),
                                  //SizedBox(width: width*0.03,),
                                  Container(
                                    width: width*0.6,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SubHeadingText(text:historyResult[i].type,fontSize: 18, ),
                                        SizedBox(height: height*0.01,),
                                        ParagraphText(text:"${DateFormat('yyyy-MM-dd').format(historyResult[i].dateTime)}, ${DateFormat('hh:mm a').format(historyResult[i].dateTime)}",fontSize: 12,)
                                      ],
                                    ),
                                  ),
                                  SubHeadingText(text:"${historyResult[i].amount} €",color: historyResult[i].type=="Sell"?ColorConstant.lightGreen:Colors.red,)
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.black12,
                            width: width,
                            height: height * 0.001,
                          )
                        ],
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
