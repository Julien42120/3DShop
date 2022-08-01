class Categorys {
  final int? id;
  final String category;
  final String image;

  Categorys({
    this.id,
    required this.category,
    required this.image,
  });

  factory Categorys.fromJson(json) {
    return Categorys(
      id: json['id'],
      category: json['category'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "category": category,
      "image": image,
    };
  }
}
