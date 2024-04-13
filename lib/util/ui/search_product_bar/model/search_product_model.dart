import 'package:innwa_mobile_dev/home/latest_phone/model/product_model.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/model/brand_model.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/model/category_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_product_model.g.dart';

@JsonSerializable()
class SearchProductModel extends ProductModel {
  const SearchProductModel({
    required super.id,
    required super.enName,
    required super.mmName,
    required super.price,
    required super.image,
    required super.slug,
    this.category,
    this.brand,
  });

  final CategoryModel? category;
  final BrandModel? brand;

  @override
  List<Object?> get props => [...super.props, category, brand];
  @override
  Map<String, dynamic> toJson() => _$SearchProductModelToJson(this);

  factory SearchProductModel.fromJson(Map<String, dynamic> json) =>
      _$SearchProductModelFromJson(json);
}
