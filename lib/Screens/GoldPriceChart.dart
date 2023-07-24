import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goldvault/Constants/ColorConstant.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/GetGoldByDate.dart';
import 'package:goldvault/Screens/ChooseGold.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomButton.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';
import 'package:intl/intl.dart';

class GoldPriceChart extends StatefulWidget {
  const GoldPriceChart({Key? key}) : super(key: key);

  @override
  State<GoldPriceChart> createState() => _GoldPriceChartState();
}

class _GoldPriceChartState extends State<GoldPriceChart> {

  var dateNow = DateTime.now();
  var startDate;
  var endDate;
  List<GetGoldByDateResult> getGoldByDateResult = [];

  List<String> date = [
    "12 Aug",
    "13 Aug",
    "14 Aug",
    "15 Aug",
    "16 Aug",
    "17 Aug"
  ];
  List<String> size = [
    "Day",
    "Week",
    "Month",
  ];

  String selectedType= "Day";
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
    getDatabyweek();
    super.initState();
  }

  getDatabyweek(){
    endDate = DateFormat('yyyy-MM-dd').format(DateTime(dateNow.year,dateNow.month,dateNow.day-1));
    startDate= DateFormat('yyyy-MM-dd').format(DateTime(dateNow.year,dateNow.month,dateNow.day-3));
    print("last...$endDate,...curr....$startDate");
    getGraphData(startDate,endDate);
    setState(() {});
  }

  getDatabyMonth(){
    endDate = DateFormat('yyyy-MM-dd').format(DateTime(dateNow.year,dateNow.month,dateNow.day-1));
    startDate= DateFormat('yyyy-MM-dd').format(DateTime(dateNow.year,dateNow.month,dateNow.day-3));
    print("last...$endDate,...curr....$startDate");
    getGraphData(startDate,endDate);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(context: context, title: "Gold Price"),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              children: [
                Column(children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SubHeadingText(
                    text: goldPriceResult==null?"":"${goldPriceResult!.price} €/g",
                    fontSize: 18,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Center(
                    child: Container(
                      width: width * 0.35,
                      child: Row(
                        children: [
                          ParagraphText(text: "Cash Balance: "),
                          SubHeadingText(
                            text: '${userAvailableAmount} €',
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                SizedBox(
                  height: height * 0.05,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      SubHeadingText(
                        text: 'Last Week',
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      ParagraphText(
                        text: '+2.36 (2%)',
                        color: ColorConstant.bluegreenColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                // ParagraphText(
                //   text: '\$873.32',
                //   color: Colors.black,
                //   fontWeight: FontWeight.bold,
                // ),
                Container(
                    width: width,
                   // height: height*0.3,
                    child:
                    getGoldByDateResult.isEmpty||getGoldByDateResult==null?Center(child: CircularProgressIndicator()):
                    showChart()),
                // Container(
                //     width: width,
                //     height: height * 0.2,
                //     child: SvgPicture.asset(
                //       "assets/images/CurvedGraphImg.svg",
                //       fit: BoxFit.cover,
                //     )),
                // SizedBox(
                //   height: height * 0.05,
                // ),
                // Container(
                //   width: width,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       for (int i = 0; i < date.length; i++)
                //         ParagraphText(
                //           text: date[i],
                //           fontSize: 15,
                //         )
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ParagraphText(
                      text: "High: 268.69 €",
                    ),
                    ParagraphText(
                      text: "Low: 268.69 €",
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Container(
                  width: width*0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < size.length; i++)
                        InkWell(
                          onTap: () {
                            selectedType =
                                size[i];
                            setState(() {
                            });
                           if(i==0){
                             getDatabyweek();
                           }
                           else if(i==1){
                             getDatabyweek();
                           }
                           else{
                             getDatabyMonth();
                           }
                          },
                          child: Container(
                            width: width * 0.15,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                                color: selectedType ==
                                    size[i]
                                    ? ColorConstant.buttonColor
                                    : Colors.transparent,
                                border: Border.all(color: Colors.black12),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Center(
                              child: ParagraphText(text: size[i]),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child:Container(
                width: width,
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      text: "BUY GOLD",
                      width: width * 0.7,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChooseGold()));
                      },
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    InkWell(
                      onTap: () {

                      },
                      child: SvgPicture.asset(
                        "assets/images/MoreButton.svg",
                        height: height*0.06,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  showChart(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
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
                leftTitles: SideTitles(showTitles: false,
                ),
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
