import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goldvault/Constants/ColorConstant.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Screens/EnterCode.dart';
import 'package:goldvault/Screens/InviteFriends.dart';
import 'package:goldvault/Widgets/CustomSnackBar.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';

class Rewards extends StatefulWidget {
  const Rewards({Key? key}) : super(key: key);

  @override
  State<Rewards> createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> with TickerProviderStateMixin{


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppBarHeadingText(text: 'Rewards'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: DefaultTabController(
          length: 2,
            initialIndex: 0,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration( borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black12.withOpacity(0.05),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                        color: ColorConstant.buttonColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(
                        text: 'Enter code',
                      ),
                      Tab(
                        text: 'Invite friends',
                      ),
                    ],
                  ),
                ),
                 Expanded(
                    child: TabBarView(
                      children: [
                        Center(
                          child: EnterCode(),
                        ),
                        Center(
                          child: InviteFriends(),
                        ),
                      ],
                    ))
              ],
            ),
          ),
      ),
    );
  }
}
