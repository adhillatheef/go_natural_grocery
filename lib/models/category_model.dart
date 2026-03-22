class CategoryModel {
  final int id;
  final String name;
  final String image;
  final String slug;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.slug,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final catData = json['category'] ?? {};

    String imageUrl = catData['image'] ?? '';
    if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
      imageUrl = 'https://sungod.demospro2023.in.net/images/category/$imageUrl';
    }

    return CategoryModel(
      id: catData['id'] ?? 0,
      name: catData['name'] ?? '',
      image: imageUrl,
      slug: catData['slug'] ?? '',
    );
  }
}