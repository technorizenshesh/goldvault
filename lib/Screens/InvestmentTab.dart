import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goldvault/Constants/ColorConstant.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/GetGoldByDate.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';
import 'package:intl/intl.dart';

class InvestmentTab extends StatefulWidget {
  const InvestmentTab({Key? key}) : super(key: key);

  @override
  State<InvestmentTab> createState() => _InvestmentTabState();
}

class _InvestmentTabState extends State<InvestmentTab> {
  List numbers = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '13',
    '16',
    '17'
  ];

  var dateNow = DateTime.now();
  var startDate;
  var endDate;
  List<GetGoldByDateResult> getGoldByDateResult = [];
  final List<double> goldRates = [];
  final List<String> dates = [];

  getGraphData(String sd,String ed) async {
    goldRates.clear();
    dates.clear();
    Map<String, dynamic> data = {
      "start_date": sd,
      "end_date": ed
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$current_price_by_date", body: data, context: context);
    print("status from api ${res}");
    final resdata = GetGoldByDate.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      getGoldByDateResult = resdata.result;
      for(int i=0;i<getGoldByDateResult.length;i++){
        goldRates.add(getGoldByDateResult[i].price);
        dates.add(DateFormat('dd-MM-yyyy').format(getGoldByDateResult[i].date).toString());
        print("date list....$dates");
        setState(() {

        });
      }
      setState(() {});
    } else {
    }
  }

  @override
  void initState() {
    endDate = DateFormat('yyyy-MM-dd').format(DateTime(dateNow.year,dateNow.month,dateNow.day-1));
    startDate= DateFormat('yyyy-MM-dd').format(DateTime(dateNow.year,dateNow.month,dateNow.day-3));
    print("last...$endDate,...curr....$startDate");
    getGraphData(startDate,endDate);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarHeadingText(
          text: "Mar".tr,
          color: Colors.white,
        ),
        centerTitle: true,
        actions: [
          Icon(
            Icons.more_vert_rounded,
            color: Colors.white,
          )
        ],
        backgroundColor: ColorConstant.buttonColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: width,
            height: height * 0.12,
            decoration: BoxDecoration(
                color: ColorConstant.buttonColor,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
              child: Container(
              //  width: width,
                //height: height * 0.06,
                decoration: BoxDecoration(
                    color: ColorConstant.yellowOpacityColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: ListTile(
                    leading:
                    Container(
                      width: width*0.13,
                      height: width*0.13,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child:
                        CachedNetworkImage( imageUrl: userImage,fit: BoxFit.cover,),
                      ),
                    ),
                    //Image.asset('assets/images/ProfileImg.png'),
                    title: SubHeadingText(text: userName,color: Colors.white,),
                    trailing: Column(
                      children: [
                        SubHeadingText(text: '\$821.87',color: Colors.white,fontSize: 20,),
                        SizedBox(height: height*0.01,),
                        ParagraphText(text: '-21.3 (12%)',color: Colors.white)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: SubHeadingText(
                  text: 'Chart'.tr,
                  fontSize: 20,
                )),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SubHeadingText(
                  //   text: 'Last Week',
                  //   fontSize: 17,
                  // ),
                  // SizedBox(
                  //   height: height * 0.01,
                  // ),
                  // ParagraphText(
                  //   text: '+2.36 (2%)',
                  //   fontSize: 16,
                  //   color: ColorConstant.lightGreen,
                  // ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                    width: width,
                      height: height*0.2,
                      child:
                      getGoldByDateResult.isEmpty?Center(child: CircularProgressIndicator(),):
                      showChart()),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       for (int i = 0; i < numbers.length; i++)
                  //         Row(
                  //           children: [
                  //             ParagraphText(text: numbers[i]),
                  //             SizedBox(
                  //               width: width * 0.1,
                  //             )
                  //           ],
                  //         ),
                  //
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: height * 0.05,
                  // ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubHeadingText(
                        text: 'Price of Gold'.tr,
                        fontSize: 17,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SubHeadingText(text: '872.75 €',fontSize: 20,),
                          SizedBox(height: height*0.01,),
                          ParagraphText(
                            text: '-12.34 (9.82%)',
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubHeadingText(
                        text: 'My Savings'.tr,
                        fontSize: 17,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SubHeadingText(text: '982.98 €',fontSize: 20,),
                          SizedBox(height: height*0.01,),
                          ParagraphText(
                            text: '-32.89 (12.8%)',
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  showChart(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: MediaQuery.of(context).size.width,
        //height: 200,
        child: Padding(
          padding: EdgeInsets.all(30),
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots:
                  List.generate(goldRates.length,(index) {
                    return FlSpot(index.toDouble(), goldRates[index]);
                  }),
                  isCurved: true,
                  colors: [Colors.green],
                  dotData: FlDotData(show: true,getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 6.0,
                      color: Colors.white,
                      strokeWidth: 2.0,
                      strokeColor: Colors.green,
                    );
                  },),
                  // show: true, // Enables tooltip on data points
                ),
              ],
              titlesData: FlTitlesData(
                bottomTitles: SideTitles(
                  showTitles: true,
                  margin: 20,
                  getTitles: (value) {
                    int index = value.toInt();
                    if (index >= 0 && index < dates.length) {
                      return dates[index];
                    }
                    return '';
                  },
                ),
                leftTitles: SideTitles(showTitles: false),
              ),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ),
    );
  }
}
