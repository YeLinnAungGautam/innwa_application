import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_vo.g.dart';

@JsonSerializable()
class Category extends Equatable {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name_en")
  final String? nameEn;

  @JsonKey(name: "name_mm")
  final String? nameMm;

  const Category({
    required this.id,
    required this.nameEn,
    required this.nameMm,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameMm,
      ];
}
