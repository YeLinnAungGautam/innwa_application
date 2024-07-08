// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      id: (json['id'] as num).toInt(),
      productId: (json['product_id'] as num).toInt(),
      customerId: (json['customer_id'] as num).toInt(),
      star: (json['star'] as num).toInt(),
      msg: json['msg'] as String,
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'customer_id': instance.customerId,
      'star': instance.star,
      'msg': instance.msg,
    };
