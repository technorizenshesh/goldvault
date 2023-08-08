import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:goldvault/Constants/ColorConstant.dart';

import 'package:goldvault/Screens/HistoryTab.dart';
import 'package:goldvault/Screens/HomeTab.dart';
import 'package:goldvault/Screens/InvestmentTab.dart';
import 'package:goldvault/Screens/ProfileTab.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TabController controller;
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    HistoryTab(),
    InvestmentTab(),
    ProfileTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(_selectedIndex == 0 ?'assets/images/HomeIconColored.svg':'assets/images/HomeIconGrey.svg',height: 25,),
              label: 'Home'.tr,
            ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(_selectedIndex == 1 ?'assets/images/HistoryIconColored.svg':'assets/images/HistoryIconGrey.svg',height: 25,),
                label: 'History'.tr),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(_selectedIndex == 2 ?'assets/images/InvestmentIconColored.svg':'assets/images/InvestmentIconGrey.svg',height: 25,),
                label: 'Investment'.tr),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(_selectedIndex == 3 ?'assets/images/ProfileIconColored.svg':'assets/images/ProfileIconGrey.svg',height: 25,),
                label: 'Profile'.tr
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: ColorConstant.buttonColor,
          unselectedItemColor: Colors.grey,
          iconSize: 30,
          onTap: _onItemTapped,
          elevation: 15),
    );
  }
}
