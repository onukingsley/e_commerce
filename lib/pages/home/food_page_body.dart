import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/controllers/recommended_product_controller.dart';
import 'package:e_commerce/models/popular_product.dart';
import 'package:e_commerce/models/recommended_product.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/icon_and_text_widget.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        print(Dimensions.screenHeight);
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProduct) {
          return popularProduct.isloaded
              ? Container(
                  height: Dimensions.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProduct.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProduct.popularProductList[position]);
                      }),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return Container(
            child: new DotsIndicator(
              dotsCount: popularProducts.popularProductList.isEmpty
                  ? 1
                  : popularProducts.popularProductList.length,
              position: _currPageValue,
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          );
        }),
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(children: [
            BigText(text: 'Popular'),
            SizedBox(
              width: Dimensions.width10,
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(
              text: 'Food Paring',
              overflow: TextOverflow.ellipsis,
            ),
          ]),
        ),
        GetBuilder<RecommendedProductController>(builder: (recommendedproduct) {
          return SingleChildScrollView(
            child: Container(
              height: 700,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedproduct.recommendedList.length,
                  itemBuilder: (context, position) {
                    return (Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.width20, bottom: Dimensions.width20),
                      decoration: BoxDecoration(),
                      child: Row(children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              color: AppColors.yellowColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'http://mvs.bslmeiyu.com/uploads/' +
                                          recommendedproduct
                                              .recommendedList[position]
                                              .img!))),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(
                                    size: Dimensions.font20,
                                    text: recommendedproduct
                                        .recommendedList[position].name!,
                                    color: AppColors.titleColor,
                                  ),
                                  SizedBox(height: Dimensions.height15),
                                  SmallText(
                                      overflow: TextOverflow.ellipsis,
                                      text: recommendedproduct
                                          .recommendedList[position].location!),
                                  SizedBox(
                                    height: Dimensions.height15,
                                  ),
                                  Row(
                                    children: [
                                      IconAndTextWidget(
                                        icon: Icons.food_bank,
                                        text: "Hot",
                                        iconColor: AppColors.yellowColor,
                                      ),
                                      SizedBox(
                                        width: Dimensions.width10,
                                      ),
                                      IconAndTextWidget(
                                        icon: Icons.lightbulb_outline_rounded,
                                        text: "Ready",
                                        iconColor: AppColors.mainColor,
                                      ),
                                      SizedBox(
                                        width: Dimensions.width10,
                                      ),
                                      IconAndTextWidget(
                                        icon: Icons.lock_clock,
                                        text: "32mins",
                                        iconColor: Colors.red,
                                      )
                                    ],
                                  )
                                ]),
                          ),
                        )
                      ]),
                    ));
                  }),
            ),
          );
        })
      ],
    );
  }

  Widget _buildPageItem(int index, Products popularProductList) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven ? Color(0xFFffd379) : Color(0xFFfcab88),
                  image: DecorationImage(
                      image: NetworkImage('http://mvs.bslmeiyu.com/uploads/' +
                          popularProductList.img!),
                      fit: BoxFit.cover)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: Dimensions.pageViewTextContainer,
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                  ],
                  color: Colors.white,
                ),
                child: Container(
                    padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(text: popularProductList.name!),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Row(
                          children: [
                            Wrap(
                              children: List.generate(
                                  popularProductList.stars!,
                                  (index) => Icon(Icons.star,
                                      color: AppColors.mainColor, size: 15)),
                            ),
                            SizedBox(width: Dimensions.height20),
                            SmallText(
                                text: "4.5", overflow: TextOverflow.ellipsis),
                            SizedBox(width: 10),
                            SmallText(
                                text: '1287', overflow: TextOverflow.ellipsis),
                            SizedBox(width: 10),
                            SmallText(
                                text: 'comments',
                                overflow: TextOverflow.ellipsis)
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                    ))),
          )
        ],
      ),
    );
  }
}
