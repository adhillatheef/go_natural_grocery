import 'package:get/get.dart';
import '../models/banner_model.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../network/api_client.dart';
import '../network/api_constants.dart';
import '../services/auth_service.dart';

class HomeController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  var banners = <BannerModel>[].obs;
  var categories = <CategoryModel>[].obs;
  var newArrivals = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    try {
      isLoading(true);
      hasError(false);

      final authService = Get.find<AuthService>();

      final response = await _apiClient.post(
        ApiConstants.home,
        queryParams: {
          'id': authService.userId,
          'token': authService.token,
        },
      );

      if (response.statusCode == 200 && response.data != null && response.data['success'] == 1) {
        final data = response.data;

        if (data['banner1'] != null) {
          banners.value = (data['banner1'] as List).map((json) => BannerModel.fromJson(json)).toList();
        }

        if (data['categories'] != null) {
          categories.value = (data['categories'] as List).map((json) => CategoryModel.fromJson(json)).toList();
        }

        if (data['newarrivals'] != null) {
          newArrivals.value = (data['newarrivals'] as List).map((json) => ProductModel.fromJson(json)).toList();
        }
      } else {
        hasError(true);
        errorMessage.value = "Failed to load data.";
      }
    } catch (e) {
      hasError(true);
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}