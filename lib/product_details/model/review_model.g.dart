// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      id: json['id'] as int,
      productId: json['product_id'] as int,
      customerId: json['customer_id'] as int,
      star: json['star'] as int,
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
