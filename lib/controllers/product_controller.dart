import 'package:get/get.dart';
import '../models/product_model.dart';
import '../network/api_client.dart';
import '../network/api_constants.dart';
import '../services/auth_service.dart';

class ProductController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  var isLoading = true.obs;
  var hasError = false.obs;
  var products = <ProductModel>[].obs;

  void fetchProductsByCategory(String categorySlug) async {
    try {
      isLoading(true);
      hasError(false);
      products.clear();

      final authService = Get.find<AuthService>();

      final response = await _apiClient.post(
        ApiConstants.products,
        queryParams: {
          'id': authService.userId,
          'token': authService.token,
          'by': 'category',
          'value': categorySlug,
        },
      );

      // Check for 200 OK and success: 1
      if (response.statusCode == 200 && response.data != null && response.data['success'] == 1) {

        // 1. Target the parent 'products' object
        final productsData = response.data['products'];

        // 2. Drill down into 'return' and then 'data' for the paginated list
        if (productsData != null && productsData['return'] != null && productsData['return']['data'] != null) {
          final List dynamicList = productsData['return']['data'];

          products.value = dynamicList.map((json) => ProductModel.fromJson(json)).toList();
        } else {
          products.value = []; // Handle empty gracefully
        }

      } else {
        hasError(true);
      }
    } catch (e) {
      hasError(true);
    } finally {
      isLoading(false);
    }
  }
}