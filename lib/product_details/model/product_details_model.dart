import 'package:equatable/equatable.dart';
import 'package:innwa_mobile_dev/product_details/model/product_image_model.dart';
import 'package:innwa_mobile_dev/product_details/model/product_specification_model.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/model/brand_model.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/model/category_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_details_model.g.dart';

@JsonSerializable()
class ProductDetailsModel extends Equatable {
  const ProductDetailsModel(
      {required this.id,
      required this.enName,
      required this.mmName,
      required this.enDesc,
      required this.category,
      required this.brand,
      required this.price,
      this.image,
      this.mmDesc});

  final int id;
  @JsonKey(name: "name_en")
  final String enName;
  @JsonKey(name: "name_mm")
  final String mmName;
  @JsonKey(name: "feature_image")
  final String? image;
  @JsonKey(name: "description_en")
  final String enDesc;
  @JsonKey(name: "description_mm")
  final String? mmDesc;
  final CategoryModel category;
  final BrandModel brand;
  final List<ProductDetailsPriceModel> price;

  @override
  List<Object?> get props => [
        id,
        enName,
        mmName,
        image,
        enDesc,
        mmDesc,
        category,
        brand,
        price,
      ];

  Map<String, dynamic> toJson() => _$ProductDetailsModelToJson(this);

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsModelFromJson(json);
}

@JsonSerializable()
class ProductDetailsPriceModel extends Equatable {
  const ProductDetailsPriceModel(
      {required this.id,
      required this.productId,
      required this.stockStatus,
      required this.stockQty,
      required this.price,
      required this.productSpecifications,
      required this.productImage,
      this.gift,
      this.sku,
      this.disStartDate,
      this.disendDate,
      this.disPrice,
      this.cashback,
      this.disImage});

  final int id;
  @JsonKey(name: "product_id")
  final int productId;
  @JsonKey(name: "stock_status")
  final String stockStatus;
  @JsonKey(name: "stock_qty")
  final String stockQty;
  final String? sku;
  @JsonKey(name: "dis_start_date")
  final String? disStartDate;
  @JsonKey(name: "dis_end_date")
  final String? disendDate;
  @JsonKey(name: "dis_price")
  final String? disPrice;
  final String? cashback;
  @JsonKey(name: "dis_image")
  final String? disImage;
  final String? gift;
  @JsonKey(name: "price_mmk")
  final int price;
  @JsonKey(name: "product_specification")
  final List<ProductSpecificationModel> productSpecifications;
  @JsonKey(name: "product_image")
  final List<ProductImageModel> productImage;
  @override
  List<Object?> get props => [
        id,
        productId,
        stockStatus,
        stockQty,
        sku,
        disStartDate,
        disendDate,
        disPrice,
        cashback,
        disImage,
        price,
        productSpecifications,
        productImage,
        gift,
      ];

  Map<String, dynamic> toJson() => _$ProductDetailsPriceModelToJson(this);

  factory ProductDetailsPriceModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsPriceModelFromJson(json);
}
