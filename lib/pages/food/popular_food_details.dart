import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetails extends StatelessWidget {
  int pageid;
  PopularFoodDetails({super.key, required this.pageid});

  @override
  Widget build(BuildContext context) {
    var products =
        Get.find<PopularProductController>().popularProductList[pageid];
    Get.find<PopularProductController>()
        .initProduct(Get.find<CartController>(), products);

    return Scaffold(
        body: Stack(children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgsize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('http://mvs.bslmeiyu.com/uploads/' +
                            products.img!))),
              )),
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.initial);
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                  AppIcon(icon: Icons.shopping_cart_checkout_outlined)
                ],
              )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgsize - Dimensions.height20,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20)),
                  color: Colors.white),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: products.name!,
                              size: Dimensions.font26,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            Row(
                              children: [
                                Wrap(
                                  children: List.generate(
                                      products.stars!,
                                      (index) => Icon(Icons.star,
                                          color: AppColors.mainColor,
                                          size: 15)),
                                ),
                                SizedBox(width: Dimensions.height20),
                                SmallText(
                                  text: "4.5",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(width: 10),
                                SmallText(
                                  text: '1287',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(width: 10),
                                SmallText(
                                  text: 'comments',
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconAndTextWidget(
                                      icon: Icons.circle_sharp,
                                      text: 'Normal',
                                      iconColor: AppColors.iconColor1),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  IconAndTextWidget(
                                      icon: Icons.location_city,
                                      text: '1.7km',
                                      iconColor: AppColors.mainColor),
                                  const SizedBox(width: 5),
                                  IconAndTextWidget(
                                      icon: Icons.lock_clock_rounded,
                                      text: '32 mins',
                                      iconColor: AppColors.iconColor2)
                                ]),
                          ],
                        )),
                    SizedBox(height: Dimensions.height20),
                    BigText(text: 'Introduce'),
                    Expanded(
                        child: SingleChildScrollView(
                            child: ExpandableTextWidget(
                                text: products.description!)))
                  ]),
            ),
          )
        ]),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (items) {
            return Container(
              height: Dimensions.pageViewTextContainer,
              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  bottom: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20 * 2),
                      topRight: Radius.circular(Dimensions.radius20 * 2))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height10,
                        bottom: Dimensions.height10,
                        left: Dimensions.width10,
                        right: Dimensions.width10),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white),
                    child: Row(children: [
                      GestureDetector(
                        onTap: () {
                          items.setquantity(false);
                        },
                        child: Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      BigText(text: items.inCartItems.toString()),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          items.setquantity(true);
                        },
                        child: Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        ),
                      )
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      items.addItem(products);
                    },
                    child: Container(
                        padding: EdgeInsets.all(Dimensions.height10),
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20)),
                        child: BigText(
                          text: products.price.toString() + "\$ Add to cart",
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            );
          },
        ));
  }
}
