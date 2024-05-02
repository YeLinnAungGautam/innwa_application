import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter_category_model.g.dart';

@JsonSerializable()
class FilterCategoryModel extends Equatable {
  const FilterCategoryModel(
      {required this.id,
      required this.enName,
      required this.childCategories,
      this.mmName});

  final int id;
  @JsonKey(name: "name_en")
  final String enName;
  @JsonKey(name: "name_mm")
  final String? mmName;
  @JsonKey(name: "child_category")
  final List<ChildCategoryModel> childCategories;
  @override
  List<Object?> get props => [id, enName, mmName, childCategories];

  Map<String, dynamic> toJson() => _$FilterCategoryModelToJson(this);

  factory FilterCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$FilterCategoryModelFromJson(json);
}

@JsonSerializable()
class ChildCategoryModel extends Equatable {
  const ChildCategoryModel({
    required this.id,
    required this.parentId,
    required this.enName,
    this.mmName,
  });
  final int id;
  @JsonKey(name: "parent_category_id")
  final int parentId;
  @JsonKey(name: "name_en")
  final String enName;
  @JsonKey(name: "name_mm")
  final String? mmName;

  @override
  List<Object?> get props => [id, parentId, enName, mmName];
  Map<String, dynamic> toJson() => _$ChildCategoryModelToJson(this);

  factory ChildCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ChildCategoryModelFromJson(json);
}
