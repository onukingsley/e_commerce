import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/popular_product.dart';
import 'package:get/get.dart';

import '../data/repository/cart_repo.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  void addItem(Products product, int quantity) {
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
        );
      });
    } else {
      _items.putIfAbsent(product.id!, () {
        return CartModel(
          id: product.id,
          name: product.name,
          price: product.price,
          img: product.img,
          quantity: quantity,
          isExist: true,
          time: DateTime.now().toString(),
        );
      });
    }
  }

  bool existInCart(Products products) {
    if (_items.containsKey(products.id!)) {
      return true;
    } else {
      return false;
    }
  }

int getQuantity(Products product){
  var quantity = 0;
  if (_items.containsKey(product.id!)){
    _items.forEach((key, value) {
      if(key == product.id!){
        quantity = value.quantity!;
      }
    });
  }
  return quantity;
}
}
