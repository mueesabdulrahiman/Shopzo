// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sample _$SampleFromJson(Map<String, dynamic> json) => Sample(
      id: json['id'] as int?,
      name: json['name'] as String?,
      status: json['status'] as String?,
      description: json['description'] as String?,
      shortDescription: json['short_description'] as String?,
      sku: json['sku'] as String?,
      price: json['price'] as String?,
      regularPrice: json['regular_price'] as String?,
      salePrice: json['sale_price'] as String?,
      stockQuantity: json['stock_quantity'] as int?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Imagee.fromJson(e as Map<String, dynamic>))
          .toList(),
      flag: json['flag'] as bool? ?? false,
    )..inStock = json['in_stock'] as bool?;

Map<String, dynamic> _$SampleToJson(Sample instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'description': instance.description,
      'short_description': instance.shortDescription,
      'sku': instance.sku,
      'price': instance.price,
      'regular_price': instance.regularPrice,
      'sale_price': instance.salePrice,
      'stock_quantity': instance.stockQuantity,
      'in_stock': instance.inStock,
      'categories': instance.categories,
      'tags': instance.tags,
      'images': instance.images,
      'flag': instance.flag,
    };
