import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/home_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_typography.dart';
import '../../widgets/product_card.dart';
import '../product/product_details_screen.dart';
import '../product/product_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject the controller
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        // Mocking the top logo/icon space from your design
        title: Row(
          children: [
            // Placeholder for the little cart logo in the top left
            Image.asset('assets/images/logo.png', height: 40,),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(LucideIcons.heart, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(LucideIcons.bell, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.circleAlert, size: 48, color: AppColors.textDisabled),
                const SizedBox(height: 16),
                Text(controller.errorMessage.value, style: AppTypography.body),
                TextButton(
                  onPressed: controller.fetchHomeData,
                  child: const Text("Retry"),
                )
              ],
            ),
          );
        }

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: controller.fetchHomeData, // Bonus feature: Pull-to-refresh!
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // 1. Banners Section
                if (controller.banners.isNotEmpty)
                  SizedBox(
                    height: 160,
                    child: PageView.builder(
                      itemCount: controller.banners.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: controller.banners[index].image,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(color: AppColors.cardBackground),
                              errorWidget: (context, url, error) => Container(color: AppColors.border),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                const SizedBox(height: 24),

                // 2. Categories Section
                _buildSectionHeader('Categories'),
                const SizedBox(height: 12),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => ProductListScreen(
                              categoryName: category.name,
                              categorySlug: category.slug,
                            ));
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.border),
                                  color: AppColors.cardBackground,
                                ),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: category.image,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>  Icon(LucideIcons.imageOff, color: AppColors.border),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: 70,
                                child: Text(
                                  category.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.caption.copyWith(color: AppColors.textMain),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // 3. Featured Products / New Arrivals Section
                _buildSectionHeader('New Arrivals'),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65, // Adjust this to fit the card content perfectly
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: controller.newArrivals.length,
                    itemBuilder: (context, index) {
                      final product = controller.newArrivals[index];
                      return ProductCard(
                        product: product,
                        onCardTap: () {
                          Get.to(() => ProductDetailsScreen(product: product));                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      }),
    );
  }

  // Helper widget for section titles
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTypography.h2.copyWith(fontSize: 18)),
          Row(
            children: [
              Icon(LucideIcons.chevronLeft, size: 20, color: AppColors.textDisabled),
              Icon(LucideIcons.chevronRight, size: 20, color: AppColors.textMain),
            ],
          )
        ],
      ),
    );
  }
}