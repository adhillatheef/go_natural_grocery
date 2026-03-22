import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_natural_grocery/bindings/main_binding.dart';
import 'utils/app_theme.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Go Natural Grocery',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      initialBinding: MainBinding(),
    );
  }
}