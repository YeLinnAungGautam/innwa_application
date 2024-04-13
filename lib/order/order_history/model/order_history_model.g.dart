// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistoryModel _$OrderHistoryModelFromJson(Map<String, dynamic> json) =>
    OrderHistoryModel(
      id: json['id'] as int,
      orderNo: json['order_no'] as String,
      subTotal: json['sub_total'] as int,
      orderStatus: json['order_status'] as String,
      paymentStatus: json['payment_status'] as String,
      orderAt: json['ordered_at'] as String,
    );

Map<String, dynamic> _$OrderHistoryModelToJson(OrderHistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_no': instance.orderNo,
      'sub_total': instance.subTotal,
      'order_status': instance.orderStatus,
      'payment_status': instance.paymentStatus,
      'ordered_at': instance.orderAt,
    };
