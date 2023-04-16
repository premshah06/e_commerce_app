import 'package:e_commerce_app/Pages/Cart/CartHistory.dart';
import 'package:e_commerce_app/Pages/Cart/CartPage.dart';
import 'package:e_commerce_app/Pages/Cart/CartPageOutSide.dart';
import 'package:e_commerce_app/Pages/Home/FoodPageBody.dart';
import 'package:e_commerce_app/Pages/Home/MainFoodPage.dart';
import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../utils/Dimensions.dart';
import '../Profile/LogoutPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List pages = [
    MainFoodPage(),
    CartHistory(),
    CartPage(),
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
                icon: Icons.archive_outlined,
                text: "History",
                textStyle: TextStyle(color: white),
              ),
              GButton(
                haptic: false,
                icon: Icons.shopping_cart_outlined,
                text: "Cart",
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
