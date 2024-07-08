import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../product_vo/product_vo.dart';

part 'product_price_vo.g.dart';

@JsonSerializable()
class ProductPrice extends Equatable {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "product_id")
  final int? productId;

  @JsonKey(name: "dis_start_date")
  final String? disStartDate;

  @JsonKey(name: "dis_end_date")
  final String? disEndDate;

  @JsonKey(name: "dis_price")
  final String? disPrice;

  @JsonKey(name: "cashback")
  final String? cashback;

  @JsonKey(name: "gift")
  final String? gift;

  @JsonKey(name: "dis_image")
  final String? disImage;

  @JsonKey(name: "deleted_at")
  final String? deletedAt;

  @JsonKey(name: "price_mmk")
  final int? priceMmk;

  @JsonKey(name: "product")
  final Product? product;

 const ProductPrice({
    required this.id,
    required this.productId,
    required this.disStartDate,
    required this.disEndDate,
    required this.disPrice,
    required this.cashback,
    required this.gift,
    required this.disImage,
    required this.deletedAt,
    required this.priceMmk,
    required this.product,
  });

  factory ProductPrice.fromJson(Map<String, dynamic> json) =>
      _$ProductPriceFromJson(json);

  Map<String, dynamic> toJson() => _$ProductPriceToJson(this);

  @override
  List<Object?> get props => [
        id,
        productId,
        disStartDate,
        disEndDate,
        disPrice,
        cashback,
        gift,
        disImage,
        deletedAt,
        priceMmk,
        product,
      ];
}
