import 'package:e_commerce/data/repository/recommended_product_repo.dart';
import 'package:e_commerce/models/recommended_product.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  RecommendedProductRepo recommendedProductRepo;
  List<dynamic> _recommendedList = [];
  List<dynamic> get recommendedList => _recommendedList;

  RecommendedProductController({required this.recommendedProductRepo});

  Future<void> getrecommendedproduct() async {
    Response response = await recommendedProductRepo.getRecommended();

    _recommendedList = [];

    if (response.statusCode == 200) {
      _recommendedList.addAll(
          RecommendedProducts.fromJson(response.body).recommendedproducts!);
      update();
    } else {}
  }
}
