import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../controllers/cart_controller.dart';
import '../models/product_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_typography.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onCardTap;
  // Note: We removed onAddTap from here because the card now manages its own cart state!

  const ProductCard({
    Key? key,
    required this.product,
    required this.onCardTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Inject the CartController so the card can listen to quantity changes
    final cartController = Get.find<CartController>();

    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image & Favorite Icon Stack
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          LucideIcons.imageOff,
                          color: AppColors.textDisabled,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(
                      LucideIcons.heart,
                      size: 20,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            // Product Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodyMedium.copyWith(fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '₹${product.price}',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 6),
                      if (product.oldPrice != '0.00' && product.oldPrice != product.price)
                        Text(
                          '₹${product.oldPrice}',
                          style: AppTypography.caption.copyWith(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // 🚀 DYNAMIC CART BUTTON AREA 🚀
                  SizedBox(
                    height: 30, // Fixed height prevents layout jumping
                    child: Obx(() {
                      // Check if this specific product is in the cart
                      final cartItem = cartController.cartItems[product.slug];
                      final isInCart = cartItem != null && cartItem.quantity > 0;

                      // If in cart, show the Plus/Minus Stepper
                      if (isInCart) {
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary, // Solid brown background
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => cartController.decreaseQuantity(product.slug),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Icon(LucideIcons.minus, color: Colors.white, size: 16),
                                ),
                              ),
                              Text(
                                '${cartItem.quantity}',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              InkWell(
                                onTap: () => cartController.increaseQuantity(product.slug),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Icon(LucideIcons.plus, color: Colors.white, size: 16),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      // If NOT in cart, show the standard "Add" button
                      return SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => cartController.addToCart(product),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: const BorderSide(color: AppColors.primary, width: 0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          icon: const Text('Add', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          label: const Icon(LucideIcons.shoppingCart, size: 14),
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}