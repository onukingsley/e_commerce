import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/data/repository/popular_product_repo.dart';
import 'package:e_commerce/models/popular_product.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  late CartController _cart;
  bool _isLoaded = false;
  bool get isloaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();

    if (response.statusCode == 200) {
      print('seen');
      _popularProductList = [];
      _popularProductList
          .addAll(ProductsModel.fromJson(response.body).products);
      print(popularProductList);
      _isLoaded = true;
      update();
    } else {
      print('unable to fetch');
    }
  }

  void setquantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkquantity(_quantity + 1);
    } else {
      _quantity = checkquantity(_quantity - 1);
    }
    update();
  }

  int checkquantity(int quantity) {
    if (quantity <= 0) {
      Get.snackbar("Cart", "items cannot go below 0",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
          isDismissible: true,
          icon: Icon(Icons.error_outline));
      return 0;
    } else if (quantity > 20) {
      Get.snackbar("Cart", "items cannot go above 20",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
          isDismissible: true,
          icon: Icon(Icons.error_outline));
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
  }

  void addItem(Products product) {
    if (_quantity > 0) {
      _cart.addItem(product, _quantity);
      _quantity = 0;
    } else {
      Get.snackbar("Cart", "Atleast you should add one item to cart!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
          isDismissible: true,
          icon: Icon(Icons.error_outline));
    }
  }
}
