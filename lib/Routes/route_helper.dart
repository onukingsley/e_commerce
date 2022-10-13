import 'package:e_commerce/pages/food/popular_food_details.dart';
import 'package:e_commerce/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";

  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(name: "/", page: () => MainFoodPage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageid = Get.parameters['pageId'];
          return PopularFoodDetails(pageid: int.parse(pageid!));
        })
  ];
}
