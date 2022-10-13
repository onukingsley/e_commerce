import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/data/api/api_client.dart';
import 'package:e_commerce/data/repository/cart_repo.dart';
import 'package:e_commerce/data/repository/popular_product_repo.dart';
import 'package:e_commerce/data/repository/recommended_product_repo.dart';
import 'package:get/get.dart';

import '../controllers/recommended_product_controller.dart';

Future<void> init() async {
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: 'http://mvs.bslmeiyu.com'));

// Repository
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());

//Controller

  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
