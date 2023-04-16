import 'package:e_commerce_app/Pages/Authentication/LoginScreen.dart';
import 'package:e_commerce_app/Pages/Cart/CartPage.dart';
import 'package:e_commerce_app/Pages/Food/PopularFoodDetail.dart';
import 'package:e_commerce_app/Pages/Food/RecommendedFoodDetail.dart';
import 'package:e_commerce_app/Pages/Home/HomePage.dart';
import 'package:e_commerce_app/Pages/Payment/RazorPayment.dart';
import 'package:e_commerce_app/Pages/Splash/SplashScreen.dart';
import 'package:get/get.dart';

import '../Pages/Home/MainFoodPage.dart';

class RouteHelper {
  static const String splashScreen = "/splash=screen";
  static const String authentication = "/authntication";
  static const String razorPayment = "/razorPayment";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";

  static String getSplashScreen() => '$splashScreen';
  static String getAuthentication() => '$authentication';
  static String getInitial() => '$initial';
  static String getRazorPayment() => '$razorPayment';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: authentication, page: () => LoginPage()),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(name: razorPayment, page: () => RazorPayment()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
      name: cartPage,
      page: () {
        return CartPage();
      },
      transition: Transition.fadeIn,
    )
  ];
}
