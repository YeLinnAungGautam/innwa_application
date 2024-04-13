import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_history_model.g.dart';

@JsonSerializable()
class OrderHistoryModel extends Equatable {
  const OrderHistoryModel(
      {required this.id,
      required this.orderNo,
      required this.subTotal,
      required this.orderStatus,
      required this.paymentStatus,
      required this.orderAt});
  final int id;
  @JsonKey(name: "order_no")
  final String orderNo;
  @JsonKey(name: "sub_total")
  final int subTotal;
  @JsonKey(name: "order_status")
  final String orderStatus;
  @JsonKey(name: "payment_status")
  final String paymentStatus;
  @JsonKey(name: "ordered_at")
  final String orderAt;

  @override
  List<Object?> get props =>
      [id, orderNo, subTotal, orderStatus, paymentStatus, orderAt];
  Map<String, dynamic> toJson() => _$OrderHistoryModelToJson(this);

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryModelFromJson(json);
}
