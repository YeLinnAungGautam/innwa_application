// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsModel _$ProductDetailsModelFromJson(Map<String, dynamic> json) =>
    ProductDetailsModel(
      id: json['id'] as int,
      enName: json['name_en'] as String,
      mmName: json['name_mm'] as String,
      enDesc: json['description_en'] as String,
      category:
          CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      brand: BrandModel.fromJson(json['brand'] as Map<String, dynamic>),
      price: (json['price'] as List<dynamic>)
          .map((e) =>
              ProductDetailsPriceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: json['feature_image'] as String?,
      mmDesc: json['description_mm'] as String?,
    );

Map<String, dynamic> _$ProductDetailsModelToJson(
        ProductDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.enName,
      'name_mm': instance.mmName,
      'feature_image': instance.image,
      'description_en': instance.enDesc,
      'description_mm': instance.mmDesc,
      'category': instance.category,
      'brand': instance.brand,
      'price': instance.price,
    };

ProductDetailsPriceModel _$ProductDetailsPriceModelFromJson(
        Map<String, dynamic> json) =>
    ProductDetailsPriceModel(
      id: json['id'] as int,
      productId: json['product_id'] as int,
      stockStatus: json['stock_status'] as String,
      stockQty: json['stock_qty'] as String,
      price: json['price_mmk'] as int,
      productSpecifications: (json['product_specification'] as List<dynamic>)
          .map((e) =>
              ProductSpecificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      productImage: (json['product_image'] as List<dynamic>)
          .map((e) => ProductImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      gift: json['gift'] as String?,
      sku: json['sku'] as String?,
      disStartDate: json['dis_start_date'] as String?,
      disendDate: json['dis_end_date'] as String?,
      disPrice: json['dis_price'] as String?,
      cashback: json['cashback'] as String?,
      disImage: json['dis_image'] as String?,
    );

Map<String, dynamic> _$ProductDetailsPriceModelToJson(
        ProductDetailsPriceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'stock_status': instance.stockStatus,
      'stock_qty': instance.stockQty,
      'sku': instance.sku,
      'dis_start_date': instance.disStartDate,
      'dis_end_date': instance.disendDate,
      'dis_price': instance.disPrice,
      'cashback': instance.cashback,
      'dis_image': instance.disImage,
      'gift': instance.gift,
      'price_mmk': instance.price,
      'product_specification': instance.productSpecifications,
      'product_image': instance.productImage,
    };
