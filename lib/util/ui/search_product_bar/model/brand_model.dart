import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand_model.g.dart';

@JsonSerializable()
class BrandModel extends Equatable {
  const BrandModel({required this.id, required this.enName, this.mmName});
  final int id;
  @JsonKey(name: "name_en")
  final String enName;
  @JsonKey(name: "name_mm")
  final String? mmName;
  @override
  List<Object?> get props => throw UnimplementedError();
  Map<String, dynamic> toJson() => _$BrandModelToJson(this);

  factory BrandModel.fromJson(Map<String, dynamic> json) =>
      _$BrandModelFromJson(json);
}
