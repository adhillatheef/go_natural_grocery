import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_natural_grocery/screens/cart/cart_screen.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/main_controller.dart';
import '../../utils/app_colors.dart';
import '../home/home_screen.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.put(MainController());

    final List<Widget> screens = [
      const HomeScreen(),
      const Center(child: Text("Categories Screen")),
      const CartScreen(),
      const Center(child: Text("Profile Screen")),
    ];

    return Scaffold(
      body: Obx(() => screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeTabIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(LucideIcons.house), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(LucideIcons.layoutGrid), label: 'Categories'),
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(LucideIcons.shoppingBasket),
                  Positioned(
                    right: -5,
                    top: -5,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      child: Obx(() {
                        final cartController = Get.find<CartController>();
                        return Text(
                          '${cartController.totalItems}',
                          style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(icon: Icon(LucideIcons.user), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
