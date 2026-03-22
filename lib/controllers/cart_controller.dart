import 'package:get/get.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartController extends GetxController {
  // Using a map keyed by product slug for efficient lookups
  var cartItems = <String, CartItemModel>{}.obs;

  // Reactive getter for total item count (for the badge)
  int get totalItems => cartItems.values.fold(0, (sum, item) => sum + item.quantity);

  // Reactive getter for total price [cite: 75]
  double get totalPrice => cartItems.values.fold(
      0.0,
          (sum, item) => sum + ((double.tryParse(item.product.price) ?? 0.0) * item.quantity)
  );

  void addToCart(ProductModel product) {
    if (cartItems.containsKey(product.slug)) {
      cartItems[product.slug]!.quantity += 1;
    } else {
      cartItems[product.slug] = CartItemModel(product: product, quantity: 1);
    }
    cartItems.refresh(); // Tells GetX to update the UI

    Get.snackbar(
      'Added to Cart',
      '${product.name} added to your cart.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void increaseQuantity(String slug) {
    if (cartItems.containsKey(slug)) {
      cartItems[slug]!.quantity += 1;
      cartItems.refresh();
    }
  }

  void decreaseQuantity(String slug) {
    if (cartItems.containsKey(slug)) {
      if (cartItems[slug]!.quantity > 1) {
        cartItems[slug]!.quantity -= 1;
      } else {
        cartItems.remove(slug); // Remove if quantity reaches 0
      }
      cartItems.refresh();
    }
  }
}