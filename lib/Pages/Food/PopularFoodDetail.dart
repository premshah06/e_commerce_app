import 'package:e_commerce_app/Controllers/CartController.dart';
import 'package:e_commerce_app/Controllers/PopularProductController.dart';
import 'package:e_commerce_app/Pages/Cart/CartPage.dart';
import 'package:e_commerce_app/Pages/Home/MainFoodPage.dart';
import 'package:e_commerce_app/Widgets/AppColumn.dart';
import 'package:e_commerce_app/Widgets/AppIcon.dart';
import 'package:e_commerce_app/Widgets/ExpandableTextWidget.dart';
import 'package:e_commerce_app/utils/AppConstants.dart';
import 'package:e_commerce_app/utils/Colors.dart';
import 'package:e_commerce_app/utils/Dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Routes/RouteHelper.dart';
import '../../Widgets/BigText.dart';
import '../../Widgets/IconTextWidget.dart';
import '../../Widgets/SmallText.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
        backgroundColor: white,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(product.img!),
                  ),
                ),
              ),
            ),
            Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (page == "cartPage") {
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios_rounded)),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 1)
                          Get.toNamed(RouteHelper.getCartPage());
                        else {
                          Get.snackbar(
                            "Add Products",
                            "First add products for going to Cart Page !",
                            backgroundColor: mainColor,
                            colorText: white,
                          );
                        }
                      },
                      child: Stack(
                        children: [
                          AppIcon(
                            icon: Icons.shopping_cart_outlined,
                          ),
                          controller.totalItems >= 1
                              ? Positioned(
                                  top: 4,
                                  right: 4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    width: Dimensions.width16 / 1.1,
                                    height: Dimensions.height16 / 1.1,
                                    child: Center(
                                      child: BigText(
                                        text:
                                            Get.find<PopularProductController>()
                                                .totalItems
                                                .toString(),
                                        size: Dimensions.font12 / 1.5,
                                        color: white,
                                      ),
                                    ),
                                  ))
                              : Container(),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize - 20,
              child: Container(
                padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                  color: white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          text: product.name!,
                          size: Dimensions.font12 * 2,
                        ),
                        IconTextWidget(
                            icon: Icons.access_time_rounded,
                            text: '32min',
                            iconColor: iconColor3),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height5,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          children: [
                            Positioned(
                                child: Wrap(
                              children: List.generate(
                                5,
                                ((index) {
                                  return Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 218, 218, 218),
                                  );
                                }),
                              ),
                            )),
                            Wrap(
                              children: List.generate(
                                product.stars!,
                                ((index) {
                                  return Icon(
                                    Icons.star,
                                    color: mainColor,
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: Dimensions.width5,
                        ),
                        SizedBox(
                          width: Dimensions.width5,
                        ),
                        SmallText(text: "1287 comments"),
                        SmallText(text: ""),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconTextWidget(
                            icon: Icons.currency_rupee_rounded,
                            text: product.price!.toString(),
                            size: Dimensions.font16,
                            iconColor: paraColor),
                        IconTextWidget(
                            icon: Icons.coffee,
                            text: 'Dairy',
                            iconColor: iconColor1),
                        Container(
                          height: Dimensions.iconSize24,
                          width: Dimensions.iconSize24,
                          decoration: BoxDecoration(
                            color: white38,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(product.vegNonVeg == "veg"
                                  ? "assets/image/veg.png"
                                  : "assets/image/non_veg.png"),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    BigText(text: "Introduce"),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: Dimensions.height20),
                        physics: BouncingScrollPhysics(),
                        child: ExpandableTextWidget(text: product.description!),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularProduct) {
            return Container(
              height: Dimensions.bottomNavBarHeight,
              padding: EdgeInsets.fromLTRB(
                Dimensions.width20,
                Dimensions.height30,
                Dimensions.width20,
                Dimensions.height30,
              ),
              decoration: BoxDecoration(
                color: buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      Dimensions.width20,
                      Dimensions.height20,
                      Dimensions.width20,
                      Dimensions.height20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius20,
                      ),
                      color: white,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(false);
                          },
                          child: Icon(
                            Icons.remove_rounded,
                            color: signColor,
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.width5,
                        ),
                        BigText(text: popularProduct.inCartItems.toString()),
                        SizedBox(
                          width: Dimensions.width5,
                        ),
                        GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(true);
                          },
                          child: Icon(
                            Icons.add_rounded,
                            color: signColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      popularProduct.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                        Dimensions.width20,
                        Dimensions.height20,
                        Dimensions.width20,
                        Dimensions.height20,
                      ),
                      child: BigText(
                        text:
                            "\₹ ${product.price! * popularProduct.inCartItems} | Add to cart",
                        color: white,
                        size: Dimensions.font20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
