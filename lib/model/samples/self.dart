import 'package:json_annotation/json_annotation.dart';

part 'self.g.dart';

@JsonSerializable()
class Self {
  String? href;

  Self({this.href});

  factory Self.fromJson(Map<String, dynamic> json) => _$SelfFromJson(json);

  Map<String, dynamic> toJson() => _$SelfToJson(this);
}
