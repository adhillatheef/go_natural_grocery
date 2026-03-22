class BannerModel {
  final int id;
  final String image;

  BannerModel({required this.id, required this.image});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    String imageUrl = json['image'] ?? '';
    if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
      // PDF mentions 'bannert', but usually it's 'banner'. We'll use what the PDF strictly said:
      imageUrl = 'https://sungod.demospro2023.in.net/images/banner/$imageUrl';
    }

    return BannerModel(id: json['id'] ?? 0, image: imageUrl);
  }
}
