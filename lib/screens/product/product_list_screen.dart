import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_typography.dart';
import '../../widgets/product_card.dart';
import 'product_details_screen.dart';

class ProductListScreen extends StatefulWidget {
  final String categoryName;
  final String categorySlug;

  const ProductListScreen({
    super.key,
    required this.categoryName,
    required this.categorySlug,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    // Fetch products when screen loads
    productController.fetchProductsByCategory(widget.categorySlug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Get.back(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.categoryName, style: AppTypography.h2),
            Obx(() => Text(
              '${productController.products.length} Items',
              style: AppTypography.caption,
            )),
          ],
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
              // Get.to(() => const CartScreen());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primary)); // Show loading indicator [cite: 59]
        }

        if (productController.hasError.value) {
          return const Center(child: Text("Failed to load products."));
        }

        if (productController.products.isEmpty) {
          return const Center(child: Text("No products found in this category.")); // Handle empty state gracefully [cite: 60]
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            final product = productController.products[index];
            return ProductCard(
              product: product,
              onCardTap: () {
                Get.to(() => ProductDetailsScreen(product: product)); // On product tap -> navigate to Product Details Page [cite: 61]
              },
            );
          },
        );
      }),
      // Bottom Sort/Filter Bar from Figma
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.arrowDownUp, color: AppColors.textMain),
                label: const Text('Sort By', style: TextStyle(color: AppColors.textMain)),
              ),
            ),
            Container(width: 1, color: AppColors.border, height: 40),
            Expanded(
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.funnel, color: AppColors.textMain),
                label: const Text('Filter', style: TextStyle(color: AppColors.textMain)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}