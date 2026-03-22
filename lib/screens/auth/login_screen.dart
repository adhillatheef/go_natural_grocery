import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_typography.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/login_bg.jpg',
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      // Handle skip action
                    },
                    child: Row(
                      children: const [
                        Text(
                          'Skip',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.chevron_right, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Login Form Section
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Login', style: AppTypography.h1),
                  const SizedBox(height: 24),

                  // Email Field [cite: 37]
                  const Text('Email Address', style: AppTypography.bodyMedium),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: authController.emailController,
                    hintText: 'johndoe@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),

                  // Password Field [cite: 38]
                  const Text('Password', style: AppTypography.bodyMedium),
                  const SizedBox(height: 8),
                  Obx(
                    () => CustomTextField(
                      controller: authController.passwordController,
                      hintText: '********',
                      obscureText: authController.isPasswordHidden.value,
                      suffixIcon: IconButton(
                        icon: Icon(authController.isPasswordHidden.value ? Icons.visibility_off : Icons.visibility, color: AppColors.textDisabled),
                        onPressed: authController.togglePasswordVisibility,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Forgot password?', style: AppTypography.body.copyWith(decoration: TextDecoration.underline)),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Login Button
                  Obx(() => CustomButton(text: 'Login', isLoading: authController.isLoading.value, onPressed: authController.login)),

                  const SizedBox(height: 24),

                  // Sign Up text
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: AppTypography.body,
                        children: [
                          const TextSpan(text: "Don't Have an account? "),
                          TextSpan(
                            text: 'Sign Up',
                            style: AppTypography.bodyMedium.copyWith(decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
