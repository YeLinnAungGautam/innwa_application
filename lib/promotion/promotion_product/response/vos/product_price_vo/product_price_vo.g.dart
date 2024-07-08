// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_price_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPrice _$ProductPriceFromJson(Map<String, dynamic> json) => ProductPrice(
      id: (json['id'] as num?)?.toInt(),
      productId: (json['product_id'] as num?)?.toInt(),
      disStartDate: json['dis_start_date'] as String?,
      disEndDate: json['dis_end_date'] as String?,
      disPrice: json['dis_price'] as String?,
      cashback: json['cashback'] as String?,
      gift: json['gift'] as String?,
      disImage: json['dis_image'] as String?,
      deletedAt: json['deleted_at'] as String?,
      priceMmk: (json['price_mmk'] as num?)?.toInt(),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductPriceToJson(ProductPrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'dis_start_date': instance.disStartDate,
      'dis_end_date': instance.disEndDate,
      'dis_price': instance.disPrice,
      'cashback': instance.cashback,
      'gift': instance.gift,
      'dis_image': instance.disImage,
      'deleted_at': instance.deletedAt,
      'price_mmk': instance.priceMmk,
      'product': instance.product,
    };
