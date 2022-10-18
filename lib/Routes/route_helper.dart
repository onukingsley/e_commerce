import 'package:e_commerce/pages/food/popular_food_details.dart';
import 'package:e_commerce/pages/home/home_page.dart';
import 'package:e_commerce/pages/home/main_food_page.dart';
import 'package:e_commerce/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashscreen = "/splashscreen";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String homepage = "/homepage";

  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';
  static String getinitial() => '$initial';
  static String getHomepage() => '$homepage';
  static String getsplashscreen() => '$splashscreen';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => HomePage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageid = Get.parameters['pageId'];
          return PopularFoodDetails(pageid: int.parse(pageid!));
        }),
    GetPage(name: splashscreen, page: () => Splashscreen())
  ];
}
