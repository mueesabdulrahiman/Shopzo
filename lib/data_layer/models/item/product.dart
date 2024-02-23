import 'package:json_annotation/json_annotation.dart';
import 'package:shop_x/data_layer/models/item/tag.dart';

import 'category.dart';
import 'image.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'short_description')
  String? shortDescription;
  @JsonKey(name: 'sku')
  String? sku;
  @JsonKey(name: 'price')
  String? price;
  @JsonKey(name: 'regular_price')
  String? regularPrice;
  @JsonKey(name: 'sale_price')
  String? salePrice;
  @JsonKey(name: 'stock_quantity')
  int? stockQuantity;
  @JsonKey(name: 'in_stock')
  bool? inStock;
  @JsonKey(name: 'categories')
  List<Category>? categories;
  @JsonKey(name: 'tags')
  List<Tag>? tags;
  @JsonKey(name: 'images')
  List<Imagee>? images;
  bool flag;

  Product(
      {this.id,
      this.name,
      this.status,
      this.description,
      this.shortDescription,
      this.sku,
      this.price,
      this.regularPrice,
      this.salePrice,
      this.stockQuantity,
      this.categories,
      this.tags,
      this.images,
      this.flag =false});

  factory Product.fromJson(Map<String, dynamic> json) {
    return _$SampleFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SampleToJson(this);
}
