import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../controllers/cart_controller.dart';
import '../../models/product_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_typography.dart';
import '../../widgets/custom_button.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Access the global cart controller
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(icon: const Icon(LucideIcons.search), onPressed: () {}),
          IconButton(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(LucideIcons.shoppingBasket),
                Positioned(
                  right: -5,
                  top: -5,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Obx(() => Text(
                      '${cartController.totalItems}',
                      style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ],
            ),
            onPressed: () {
              // Navigate to Cart Screen (optional depending on time)
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image [cite: 64]
            Container(
              width: double.infinity,
              height: 300,
              color: AppColors.cardBackground,
              child: CachedNetworkImage(
                imageUrl: product.image,
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(LucideIcons.imageOff, size: 50, color: AppColors.border),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name [cite: 65]
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: AppTypography.h2,
                        ),
                      ),
                      const Icon(LucideIcons.heart, color: AppColors.textDisabled),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Pricing [cite: 67]
                  Row(
                    children: [
                      Text(
                        '₹${product.price}',
                        style: AppTypography.h1.copyWith(color: AppColors.primary),
                      ),
                      const SizedBox(width: 12),
                      if (product.oldPrice != '0.00' && product.oldPrice != product.price)
                        Text(
                          '₹${product.oldPrice}',
                          style: AppTypography.body.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: AppColors.textDisabled,
                          ),
                        ),
                    ],
                  ),

                  const Divider(height: 32, color: AppColors.border),

                  // Description [cite: 66]
                  Text('Description', style: AppTypography.h2.copyWith(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text(
                    // Fallback description since API provided in Postman throws an error
                    'This is a premium quality ${product.name}. Harvested and packed with care to ensure the highest standard of quality and freshness for you and your family.',
                    style: AppTypography.body.copyWith(color: AppColors.textDisabled, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Add to Cart Bottom Bar
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: CustomButton(
            text: 'Add To Cart',
            onPressed: () {
              cartController.addToCart(product);
            },
          ),
        ),
      ),
    );
  }
}