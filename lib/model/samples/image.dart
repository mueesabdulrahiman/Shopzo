import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class Imagee {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'date_created')
  String? dateCreated;
  @JsonKey(name: 'date_created_gmt')
  String? dateCreatedGmt;
  @JsonKey(name: 'date_modified')
  String? dateModified;
  @JsonKey(name: 'date_modified_gmt')
  String? dateModifiedGmt;
  @JsonKey(name: 'src')
  String? src;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'alt')
  String? alt;
  @JsonKey(name: 'position')
  int? position;

  Imagee({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.src,
    this.name,
    this.alt,
    this.position,
  });

  factory Imagee.fromJson(Map<String, dynamic> json) => _$ImageeFromJson(json);

  Map<String, dynamic> toJson() => _$ImageeToJson(this);
}
