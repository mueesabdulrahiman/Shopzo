import 'package:json_annotation/json_annotation.dart';

part 'collection.g.dart';

@JsonSerializable()
class Collection {
  String? href;

  Collection({this.href});

  factory Collection.fromJson(Map<String, dynamic> json) {
    return _$CollectionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}
