import 'dart:async';

import 'package:e_commerce_app/Routes/RouteHelper.dart';
import 'package:e_commerce_app/utils/Dimensions.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

import '../../Controllers/PopularProductController.dart';
import '../../Controllers/RecommendedProductController.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResource();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(const Duration(seconds: 1),
        () => Get.offNamed(RouteHelper.getAuthentication()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: Dimensions.height20,
          ),
          Center(
            child: Image.asset(
              "assets/image/logo1.png",
              width: Dimensions.splashImg,
            ),
          ),
          // ScaleTransition(
          //   scale: animation,
          //   child: Center(
          //     child: Image.asset(
          //       "assets/image/logo1.png",
          //       width: Dimensions.splashImg,
          //     ),
          //   ),
          // ),
          SizedBox(
            height: Dimensions.height20,
          ),
          // FadeTransition(
          //   opacity: animation,
          //   child: Center(
          //     child: Image.asset(
          //       "assets/image/logo2.png",
          //       width: Dimensions.splashImgText,
          //     ),
          //   ),
          // ),
          Center(
            child: Image.asset(
              "assets/image/logo2.png",
              width: Dimensions.splashImgText,
            ),
          ),
        ],
      ),
    );
  }
}
