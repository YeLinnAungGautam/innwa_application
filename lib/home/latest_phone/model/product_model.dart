import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.enName,
    required this.mmName,
    required this.price,
    required this.image,
    required this.slug,
  });

  final int id;
  @JsonKey(name: "name_en")
  final String enName;
  @JsonKey(name: "name_mm")
  final String mmName;
  @JsonKey(name: "first_price")
  final PriceModel price;
  @JsonKey(name: "feature_image")
  final String image;
  final String slug;

  @override
  List<Object?> get props => [id, enName, mmName, price, image, slug];

  ProductModel copyWith({
    int? id,
    String? enName,
    String? mmName,
    PriceModel? price,
    String? image,
    String? slug,
  }) {
    return ProductModel(
      id: id ?? this.id,
      enName: enName ?? this.enName,
      mmName: mmName ?? this.mmName,
      price: price ?? this.price,
      image: image ?? this.image,
      slug: slug ?? this.slug,
    );
  }

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

@JsonSerializable()
class PriceModel extends Equatable {
  const PriceModel({
    required this.id,
    required this.productId,
    required this.amount,
    this.disPrice,
    this.disStartDate,
    this.disEndDate,
    this.cashback,
    this.gift,
  });

  final int id;
  @JsonKey(name: "product_id")
  final int productId;
  @JsonKey(name: "dis_price")
  final String? disPrice;
  @JsonKey(name: "price_mmk")
  final double amount;
  @JsonKey(name: "dis_start_date")
  final String? disStartDate;
  @JsonKey(name: "dis_end_date")
  final String? disEndDate;
  @JsonKey(name: "cashback")
  final String? cashback;
  final String? gift;

  @override
  List<Object?> get props => [
        id,
        productId,
        disPrice,
        amount,
        disStartDate,
        disEndDate,
        cashback,
        gift,
      ];
  PriceModel copyWith({
    int? id,
    int? productId,
    String? disPrice,
    double? amount,
    String? disStartDate,
    String? disEndDate,
    String? cashback,
    String? gift,
  }) {
    return PriceModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      disPrice: disPrice ?? this.disPrice,
      amount: amount ?? this.amount,
      disStartDate: disStartDate ?? this.disStartDate,
      disEndDate: disEndDate ?? this.disEndDate,
      cashback: cashback ?? this.cashback,
      gift: gift ?? this.gift,
    );
  }

  Map<String, dynamic> toJson() => _$PriceModelToJson(this);

  factory PriceModel.fromJson(Map<String, dynamic> json) =>
      _$PriceModelFromJson(json);
}
