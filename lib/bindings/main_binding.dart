import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../services/auth_service.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService(), permanent: true);
    Get.put(CartController(), permanent: true);
  }
}