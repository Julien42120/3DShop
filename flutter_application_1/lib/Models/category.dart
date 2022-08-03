class Categorys {
  final int? id;
  final String category;
  final String image;

  const Categorys({
    this.id,
    required this.category,
    required this.image,
  });

  // Categorys.empty(this.id, this.category, this.image);

  factory Categorys.fromJson(Map<String, dynamic> json) {
    return Categorys(
      id: json['id'],
      category: json['category'],
      image: json['image'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     "id": id,
  //     "category": category,
  //     "image": image,
  //   };
  // }
}
