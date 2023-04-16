import 'package:e_commerce_app/Pages/Cart/CartHistory.dart';
import 'package:e_commerce_app/Pages/Cart/CartPage.dart';
import 'package:e_commerce_app/Pages/Cart/CartPageOutSide.dart';
import 'package:e_commerce_app/Pages/Home/MainFoodPage.dart';
import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../utils/Dimensions.dart';
import '../Profile/LogoutPage.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({Key? key}) : super(key: key);

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  int _selectedIndex = 0;

  final List pages = [
    CartHistory(),
    LogoutPage(),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
        height: Dimensions.height20 * 4,
        child: GNav(
            onTabChange: onTapNav,
            // selectedIndex: _selectedIndex,
            backgroundColor: white,
            color: mainColor,
            activeColor: white,
            tabBackgroundColor: mainColor,
            padding: EdgeInsets.all(12),
            gap: 8,
            tabs: [
              GButton(
                icon: Icons.home_outlined,
                text: "Home",
                textStyle: TextStyle(color: white),
              ),
              GButton(
                icon: Icons.person_outline,
                text: "Profile",
                textStyle: TextStyle(color: white),
              ),
            ]),
      ),
    );
  }
}
