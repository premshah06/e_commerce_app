import 'dart:convert';

import 'package:e_commerce_app/Base/NoDataPage.dart';
import 'package:e_commerce_app/Controllers/CartController.dart';
import 'package:e_commerce_app/Routes/RouteHelper.dart';
import 'package:e_commerce_app/Widgets/AppIcon.dart';
import 'package:e_commerce_app/Widgets/BigText.dart';
import 'package:e_commerce_app/Widgets/SmallText.dart';
import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/utils/AppConstants.dart';
import 'package:e_commerce_app/utils/Colors.dart';
import 'package:e_commerce_app/utils/Dimensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Models/CartModel.dart';

class CartHistory extends StatelessWidget {
  CartHistory({Key? key}) : super(key: key);
  final referenceDatabase = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) {
        return e.value;
      }).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) {
        return e.key;
      }).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;

    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();

      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd hh:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);

        var inputDate = DateTime.parse(parseDate.toString());

        var outputFormat = DateFormat("dd/MM/yyyy hh:mm a");

        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }

    final ref = referenceDatabase.reference();

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.height20 * 5,
            color: mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(
              top: Dimensions.height15 * 3,
              left: Dimensions.width15,
              right: Dimensions.width15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(
                  text: "Cart History",
                  color: white,
                ),
                Container(
                  width: Dimensions.width25 * 3,
                  child: AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: mainColor,
                  ),
                )
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (cartController) {
            return cartController.getCartHistoryList().length > 0
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                      ),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            for (int i = 0; i < itemsPerOrder.length; i++)
                              Container(
                                height: Dimensions.height20 * 6,
                                margin: EdgeInsets.only(
                                  bottom: Dimensions.height20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    timeWidget(listCounter),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(
                                                itemsPerOrder[i], (index) {
                                              if (listCounter <
                                                  getCartHistoryList.length) {
                                                listCounter++;
                                              }
                                              return index <= 2
                                                  ? Container(
                                                      height:
                                                          Dimensions.height20 *
                                                              4,
                                                      width:
                                                          Dimensions.height20 *
                                                              4,
                                                      margin: EdgeInsets.only(
                                                          right: Dimensions
                                                              .width5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          Dimensions.radius20 /
                                                              2,
                                                        ),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image:
                                                              // AssetImage(
                                                              //     "assets/image/samosa.png"),
                                                              NetworkImage(
                                                                  getCartHistoryList[
                                                                          listCounter -
                                                                              1]
                                                                      .img!),
                                                        ),
                                                      ),
                                                    )
                                                  : Container();
                                            })),
                                        Container(
                                          height: Dimensions.height20 * 4,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SmallText(
                                                text: "Total",
                                                color: titleColor,
                                              ),
                                              BigText(
                                                text: itemsPerOrder[i]
                                                        .toString() +
                                                    " Items",
                                                color: titleColor,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  //Below Code is Temp Code::
                                                  final user = FirebaseAuth
                                                      .instance.currentUser;
                                                  final snap =
                                                      await ref.root.get();
                                                  print("snap.value");
                                                  print(snap.value);

                                                  //Below Code is Real Code::
                                                  var orderTime =
                                                      cartOrderTimeToList();
                                                  Map<int, CartModel>
                                                      moreOrder = {};
                                                  for (int j = 0;
                                                      j <
                                                          getCartHistoryList
                                                              .length;
                                                      j++) {
                                                    if (getCartHistoryList[j]
                                                            .time ==
                                                        orderTime[i]) {
                                                      moreOrder.putIfAbsent(
                                                          getCartHistoryList[j]
                                                              .id!,
                                                          () => CartModel.fromJson(
                                                              jsonDecode(jsonEncode(
                                                                  getCartHistoryList[
                                                                      j]))));
                                                    }
                                                  }
                                                  Get.find<CartController>()
                                                      .setItems = moreOrder;
                                                  Get.find<CartController>()
                                                      .addToCartList();
                                                  Get.toNamed(RouteHelper
                                                      .getCartPage());
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Dimensions.width10,
                                                    vertical:
                                                        Dimensions.height5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                    .radius15 /
                                                                3),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: mainColor),
                                                  ),
                                                  child: SmallText(
                                                    text: "one more",
                                                    color: mainColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height / 1.6,
                    child: Center(
                      child: NoDataPage(
                        text: "You didn`t buy anything so far!",
                        imgPath: "assets/image/no_order.png",
                      ),
                    ),
                  );
          })
        ],
      ),
    );
  }
}
