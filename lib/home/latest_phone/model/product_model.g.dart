// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as int,
      enName: json['name_en'] as String,
      mmName: json['name_mm'] as String,
      price: PriceModel.fromJson(json['first_price'] as Map<String, dynamic>),
      image: json['feature_image'] as String,
      slug: json['slug'] as String,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.enName,
      'name_mm': instance.mmName,
      'first_price': instance.price,
      'feature_image': instance.image,
      'slug': instance.slug,
    };

PriceModel _$PriceModelFromJson(Map<String, dynamic> json) => PriceModel(
      productId: json['product_id'] as int,
      amount: (json['price_mmk'] as num).toDouble(),
      disPrice: json['dis_price'] as String?,
      disStartDate: json['dis_start_date'] as String?,
      disEndDate: json['dis_end_date'] as String?,
      cashback: json['cashback'] as String?,
      gift: json['gift'] as String?,
    );

Map<String, dynamic> _$PriceModelToJson(PriceModel instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'dis_price': instance.disPrice,
      'price_mmk': instance.amount,
      'dis_start_date': instance.disStartDate,
      'dis_end_date': instance.disEndDate,
      'cashback': instance.cashback,
      'gift': instance.gift,
    };
