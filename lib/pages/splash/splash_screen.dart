import 'dart:async';

import 'package:e_commerce/Routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../utils/dimensions.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with TickerProviderStateMixin {
  void _loadresources() {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getrecommendedproduct();
    Get.find<CartController>();
  }

  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    _loadresources();
    controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 3))
          ..forward();
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(Duration(seconds: 4), () => {Get.offNamed(RouteHelper.getinitial())});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(
                  child: Image.asset("assets/image/food2.png",
                      width: Dimensions.pageViewContainer)))
        ],
      ),
    );
  }
}
