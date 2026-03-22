import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../controllers/cart_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_typography.dart';
import '../../widgets/custom_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const Center(
            child: Text('Your cart is empty', style: AppTypography.h2),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: cartController.cartItems.length,
          separatorBuilder: (_, __) => const Divider(color: AppColors.border),
          itemBuilder: (context, index) {
            String slug = cartController.cartItems.keys.elementAt(index);
            var cartItem = cartController.cartItems[slug]!;

            return Row(
              children: [
                // Product Image
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.network(cartItem.product.image, fit: BoxFit.contain),
                ),
                const SizedBox(width: 12),

                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartItem.product.name, style: AppTypography.bodyMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Text('₹${cartItem.product.price}', style: AppTypography.bodyMedium.copyWith(color: AppColors.primary)),
                    ],
                  ),
                ),

                // Quantity Controls
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(LucideIcons.circleMinus, color: AppColors.textDisabled),
                      onPressed: () => cartController.decreaseQuantity(slug),
                    ),
                    Text('${cartItem.quantity}', style: AppTypography.bodyMedium),
                    IconButton(
                      icon: const Icon(LucideIcons.circlePlus, color: AppColors.primary),
                      onPressed: () => cartController.increaseQuantity(slug),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      }),
      // Cart Summary Bottom Bar
      bottomNavigationBar: Obx(() {
        if (cartController.cartItems.isEmpty) return const SizedBox.shrink();

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5)),
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total (${cartController.totalItems} items)', style: AppTypography.body),
                    Text('₹${cartController.totalPrice.toStringAsFixed(2)}', style: AppTypography.h2.copyWith(color: AppColors.primary)),
                  ],
                ),
                const SizedBox(height: 12),
                CustomButton(
                  text: 'Proceed to Checkout',
                  onPressed: () {
                    Get.snackbar('Checkout', 'Checkout functionality coming soon!');
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}