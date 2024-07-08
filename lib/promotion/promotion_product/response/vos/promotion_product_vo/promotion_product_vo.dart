import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../product_price_vo/product_price_vo.dart';

part 'promotion_product_vo.g.dart';

@JsonSerializable()
class PromotionProduct extends Equatable {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "promotion_id")
  final int? promotionId;

  @JsonKey(name: "product_price_id")
  final int? productPriceId;

  @JsonKey(name: "product_price")
  final ProductPrice? productPrice;

  const PromotionProduct({
    required this.id,
    required this.promotionId,
    required this.productPriceId,
    required this.productPrice,
  });

  factory PromotionProduct.fromJson(Map<String, dynamic> json) =>
      _$PromotionProductFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionProductToJson(this);

  @override
  List<Object?> get props => [
        id,
        promotionId,
        productPriceId,
        productPrice,
      ];
}
