// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponModel _$CouponModelFromJson(Map<String, dynamic> json) => CouponModel(
      id: json['id'] as int,
      couponCode: json['coupon_code'] as String,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      isActive: json['is_active'] as int,
      numberOfCoupon: json['number_of_coupon'] as int,
      couponDisPrice: (json['coupon_dis_price'] as num?)?.toDouble(),
      gift: json['gift'] as String?,
    );

Map<String, dynamic> _$CouponModelToJson(CouponModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'coupon_code': instance.couponCode,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'coupon_dis_price': instance.couponDisPrice,
      'is_active': instance.isActive,
      'gift': instance.gift,
      'number_of_coupon': instance.numberOfCoupon,
    };
