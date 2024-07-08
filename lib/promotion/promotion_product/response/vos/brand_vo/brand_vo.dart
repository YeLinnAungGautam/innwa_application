import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand_vo.g.dart';

@JsonSerializable()
class Brand extends Equatable {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name_en")
  final String? nameEn;

  @JsonKey(name: "name_mm")
  final String? nameMm;

  const Brand({
    required this.id,
    required this.nameEn,
    required this.nameMm,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameMm,
      ];
}
