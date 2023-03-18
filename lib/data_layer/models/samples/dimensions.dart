import 'package:json_annotation/json_annotation.dart';

part 'dimensions.g.dart';

@JsonSerializable()
class Dimensions {
  String? length;
  String? width;
  String? height;

  Dimensions({this.length, this.width, this.height});

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return _$DimensionsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DimensionsToJson(this);
}
