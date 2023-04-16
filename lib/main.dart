import 'package:e_commerce_app/Controllers/CartController.dart';
import 'package:e_commerce_app/Controllers/PopularProductController.dart';
import 'package:e_commerce_app/Pages/Authentication/LoginScreen.dart';
import 'package:e_commerce_app/Pages/Cart/CartHistory.dart';
import 'package:e_commerce_app/Pages/Cart/CartPage.dart';
import 'package:e_commerce_app/Pages/Food/PopularFoodDetail.dart';
import 'package:e_commerce_app/Pages/Food/RecommendedFoodDetail.dart';
import 'package:e_commerce_app/Pages/Home/HomePage.dart';
import 'package:e_commerce_app/Pages/Home/MainFoodPage.dart';
import 'package:e_commerce_app/Pages/Splash/SplashScreen.dart';
import 'package:e_commerce_app/Routes/RouteHelper.dart';
import 'package:e_commerce_app/utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'Controllers/RecommendedProductController.dart';
import 'helper/Dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(builder: (_) {
          return GetMaterialApp(
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            initialRoute: RouteHelper.getSplashScreen(),
            getPages: RouteHelper.routes,
          );
        });
      },
    );
  }
}
