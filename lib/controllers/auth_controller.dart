import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../network/api_client.dart';
import '../network/api_constants.dart';
import '../services/auth_service.dart';
import '../screens/main/main_navigation.dart';

class AuthController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  final emailController = TextEditingController(text: 'mobile@alisonsgroup.com'); // Pre-filled for fast testing
  final passwordController = TextEditingController(text: '12345678');

  final isPasswordHidden = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please enter both email and password', backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    try {
      isLoading.value = true;

      // Make the actual login API call using Query Parameters
      final response = await _apiClient.post(
        ApiConstants.login,
        queryParams: {
          'email_phone': email,
          'password': password,
        },
      );

      // Check if the API returned success: 1
      if (response.data != null && response.data['success'] == 1) {

        // Extract data
        final customerData = response.data['customerdata'];
        final String id = customerData['id'];
        final String token = customerData['token'];

        // Save to our global Auth Service
        Get.find<AuthService>().saveCredentials(id, token);

        Get.snackbar('Success', response.data['message'] ?? 'Login successful!', backgroundColor: Colors.green, colorText: Colors.white);

        // Navigate to Home
        Get.offAll(() => const MainNavigationScreen());

      } else {
        Get.snackbar('Login Failed', response.data['message'] ?? 'Invalid credentials.', backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong. Please try again.', backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}