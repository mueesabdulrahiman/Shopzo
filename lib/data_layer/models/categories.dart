class Category {
  int? categoryId;
  String? categoryName;
  String? categoryDesc;
  int? parent;
  Imagee? image;
  Category(
      {this.categoryId,
      this.categoryName,
      this.categoryDesc,
      this.parent,
      this.image});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['id'],
      categoryName: json['name'],
      categoryDesc: json['description'],
      parent: json['parent'],
      image: json['image'] != null ? Imagee.formJson(json['image']) : null,
    );
  }
}

class Imagee {
  String? src;
  Imagee({this.src});
  factory Imagee.formJson(Map<String, dynamic> json) {
    return Imagee(src: json['src']);
  }
}
