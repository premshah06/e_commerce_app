import 'package:e_commerce_app/Controllers/PopularProductController.dart';
import 'package:e_commerce_app/Models/ProductsModel.dart';
import 'package:e_commerce_app/Pages/Food/PopularFoodDetail.dart';
import 'package:e_commerce_app/Routes/RouteHelper.dart';
import 'package:e_commerce_app/Widgets/AppColumn.dart';
import 'package:e_commerce_app/Widgets/BigText.dart';
import 'package:e_commerce_app/Widgets/IconTextWidget.dart';
import 'package:e_commerce_app/Widgets/SmallText.dart';
import 'package:e_commerce_app/utils/AppConstants.dart';
import 'package:e_commerce_app/utils/Colors.dart';
import 'package:e_commerce_app/utils/Dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Controllers/RecommendedProductController.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var currentPageValue = 0.0;
  var scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? SizedBox(
                  height: Dimensions.pageView,
                  child: PageView.builder(
                      physics: BouncingScrollPhysics(),
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return BuildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }),
                )
              : CircularProgressIndicator(
                  color: mainColor,
                );
        }),
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return SmoothPageIndicator(
            onDotClicked: (index) {},
            controller: pageController,
            count: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            effect: WormEffect(
              dotHeight: 10,
              dotWidth: 10,
              spacing: 10,
              dotColor: black26,
              activeDotColor: mainColor,
              type: WormType.normal,
              // strokeWidth: 5,
            ),
          );
        }),
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            BigText(text: "Recommended"),
            SizedBox(
              width: Dimensions.width10,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 3),
              child: BigText(
                text: ".",
                color: black26,
              ),
            ),
            SizedBox(width: Dimensions.width10),
            Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food Pairing"))
          ]),
        ),
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProduct.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                            RouteHelper.getRecommendedFood(index, "home"));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.width10),
                        child: Row(children: [
                          Container(
                            height: Dimensions.listViewImgSize,
                            width: Dimensions.listViewImgSize,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: white38,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      // AssetImage("assets/image/food1.jpg"),

                                      NetworkImage(recommendedProduct
                                          .recommendedProductList[index].img!),
                                )),
                          ),
                          Expanded(
                            child: Container(
                              height: Dimensions.listViewTextContSize,
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.only(
                                  topRight:
                                      Radius.circular(Dimensions.radius20),
                                  bottomRight:
                                      Radius.circular(Dimensions.radius20),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: Dimensions.width10,
                                  right: Dimensions.width20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(
                                      text: recommendedProduct
                                          .recommendedProductList[index].name!,
                                      size: Dimensions.font20,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    SmallText(
                                        text: "With chinese characteristics"),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconTextWidget(
                                            icon: Icons.currency_rupee_rounded,
                                            text: recommendedProduct
                                                .recommendedProductList[index]
                                                .price!
                                                .toString(),
                                            size: Dimensions.font16,
                                            iconColor: paraColor),
                                        IconTextWidget(
                                            icon: Icons.coffee,
                                            text: 'Dairy',
                                            iconColor: iconColor2),
                                        Container(
                                          height: Dimensions.iconSize24,
                                          width: Dimensions.iconSize24,
                                          decoration: BoxDecoration(
                                            color: white38,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(recommendedProduct
                                                          .recommendedProductList[
                                                              index]
                                                          .vegNonVeg ==
                                                      "veg"
                                                  ? "assets/image/veg.png"
                                                  : "assets/image/non_veg.png"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]),
                      ),
                    );
                  })
              : CircularProgressIndicator(
                  color: mainColor,
                );
        }),
      ],
    );
  }

  Widget BuildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == currentPageValue.floor()) {
      var currScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currentPageValue.floor() + 1) {
      var currScale =
          scaleFactor + (currentPageValue - index + 1) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currentPageValue.floor() - 1) {
      var currScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, "home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Color(0xff69c5df) : Color(0xff9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:
                      // AssetImage("assets/image/food1.jpg"),

                      NetworkImage(popularProduct.img!),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: Dimensions.pageViewTextContainer,
                margin: EdgeInsets.only(
                  left: Dimensions.width25,
                  right: Dimensions.width25,
                  bottom: Dimensions.height30,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffe8e8e8),
                        offset: Offset(0, 5),
                        blurRadius: 7.0,
                      ),
                      BoxShadow(
                        color: white,
                        offset: Offset(-5, 0),
                      ),
                      BoxShadow(
                        color: white,
                        offset: Offset(5, 0),
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  // child: AppColumn(
                  //   text: popularProduct.name!,
                  // ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BigText(
                            text: popularProduct.name!,
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
                                  popularProduct.stars!,
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
                              text: popularProduct.price!.toString(),
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
                                image: AssetImage(
                                    popularProduct.vegNonVeg == "veg"
                                        ? "assets/image/veg.png"
                                        : "assets/image/non_veg.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
