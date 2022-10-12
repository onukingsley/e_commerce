import 'package:e_commerce/data/api/api_client.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetConnect implements GetxService {
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommended() async {
    return await apiClient.getdata('/api/v1/products/popular');
  }
}
