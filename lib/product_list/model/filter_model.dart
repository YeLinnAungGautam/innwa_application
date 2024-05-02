import 'package:equatable/equatable.dart';
import 'package:innwa_mobile_dev/product_list/model/filter_category_model.dart';
import 'package:innwa_mobile_dev/product_list/model/filter_spec_model.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/model/brand_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter_model.g.dart';

@JsonSerializable()
class FilterModel extends Equatable {
  const FilterModel(
      {required this.featureImage,
      required this.disImage,
      required this.categories,
      required this.brands,
      required this.specTypes});
  @JsonKey(name: "product_feature_image_path")
  final String featureImage;
  @JsonKey(name: "dis_image_path")
  final String disImage;

  final List<FilterCategoryModel> categories;
  final List<BrandModel> brands;
  @JsonKey(name: "spec_types")
  final List<SpecTypeModel> specTypes;

  @override
  // TODO: implement props
  List<Object?> get props =>
      [featureImage, disImage, categories, brands, specTypes];
  Map<String, dynamic> toJson() => _$FilterModelToJson(this);

  factory FilterModel.fromJson(Map<String, dynamic> json) =>
      _$FilterModelFromJson(json);
}
