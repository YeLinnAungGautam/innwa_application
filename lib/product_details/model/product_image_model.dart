import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_image_model.g.dart';

@JsonSerializable()
class ProductImageModel extends Equatable {
  const ProductImageModel(
      {required this.id,
      required this.productId,
      required this.productPriceId,
      required this.image});
  final int id;
  @JsonKey(name: "product_id")
  final int productId;
  @JsonKey(name: "product_price_id")
  final int productPriceId;
  @JsonKey(name: "image")
  final String image;
  @override
  List<Object?> get props => [id, productId, productPriceId, image];
  Map<String, dynamic> toJson() => _$ProductImageModelToJson(this);

  factory ProductImageModel.fromJson(Map<String, dynamic> json) =>
      _$ProductImageModelFromJson(json);
}
