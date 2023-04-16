import 'package:e_commerce_app/Controllers/CartController.dart';
import 'package:e_commerce_app/Controllers/PopularProductController.dart';
import 'package:e_commerce_app/Data/API/ApiClient.dart';
import 'package:e_commerce_app/Data/Repository/CartRepo.dart';
import 'package:e_commerce_app/Data/Repository/PopularProductRepo.dart';
import 'package:e_commerce_app/utils/AppConstants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controllers/RecommendedProductController.dart';
import '../Data/Repository/RecommendedProductRepo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
