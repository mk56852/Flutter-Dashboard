class Category {
  int id;
  String name;
  String? imageUrl;
  Category({required this.id, required this.name, this.imageUrl});
  Category.build(this.id, this.name, this.imageUrl);

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category.build(
        json['id'], json['name'], json['imageUrl'] as String?);
  }
}
