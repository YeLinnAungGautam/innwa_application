import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel extends Equatable {
  const CategoryModel({required this.id, required this.enName, this.mmName});
  final int id;
  @JsonKey(name: "name_en")
  final String enName;
  @JsonKey(name: "name_mm")
  final String? mmName;
  @override
  List<Object?> get props => [id, enName, mmName];

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
