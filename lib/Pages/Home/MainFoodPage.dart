import 'package:e_commerce_app/Widgets/BigText.dart';
import 'package:e_commerce_app/Widgets/SmallText.dart';
import 'package:e_commerce_app/utils/Dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:e_commerce_app/utils/Colors.dart';

import 'FoodPageBody.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    // print("current height => " + MediaQuery.of(context).size.height.toString());
    // print("current width => " + MediaQuery.of(context).size.width.toString());
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
                margin: EdgeInsets.only(
                  top: Dimensions.height45,
                  bottom: Dimensions.height15,
                ),
                padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(
                          text: "Gujarat",
                          color: mainColor,
                        ),
                        Row(
                          children: [
                            SmallText(
                              text: "Changa",
                              color: black54,
                            ),
                            Icon(
                              Icons.arrow_drop_down_rounded,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: Dimensions.width45,
                        height: Dimensions.height45,
                        child: Icon(
                          Icons.search_rounded,
                          color: white,
                          size: Dimensions.iconSize24,
                        ),
                        decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15)),
                      ),
                    )
                  ],
                )),
          ),
          Expanded(
              child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: FoodPageBody(),
          )),
        ],
      ),
    );
  }
}
