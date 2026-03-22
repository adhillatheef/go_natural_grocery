class ProductModel {
  final String slug;
  final String name;
  final String price;
  final String oldPrice;
  final String image;

  ProductModel({
    required this.slug,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    String imageUrl = json['image'] ?? '';
    if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
      imageUrl = 'https://sungod.demospro2023.in.net/images/product/$imageUrl';
    }

    return ProductModel(
      slug: json['slug'] ?? '',
      name: json['name'] ?? '',
      price: json['price']?.toString() ?? '0.00',
      oldPrice: json['oldprice']?.toString() ?? '0.00',
      image: imageUrl,
    );
  }
}