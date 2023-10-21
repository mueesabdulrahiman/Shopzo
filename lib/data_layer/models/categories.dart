class Categories {
  int? categoryId;
  String? categoryName;
  String? categoryDesc;
  int? parent;
  Imagee? image;
  Categories(
      {this.categoryId,
      this.categoryName,
      this.categoryDesc,
      this.parent,
      this.image});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
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
