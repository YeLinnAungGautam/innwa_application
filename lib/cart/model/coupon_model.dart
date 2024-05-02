import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coupon_model.g.dart';

@JsonSerializable()
class CouponModel extends Equatable {
  const CouponModel(
      {required this.id,
      required this.couponCode,
      required this.startDate,
      required this.endDate,
      required this.isActive,
      required this.numberOfCoupon,
      this.couponDisPrice,
      this.gift});

  final int id;
  @JsonKey(name: "coupon_code")
  final String couponCode;
  @JsonKey(name: "start_date")
  final String startDate;
  @JsonKey(name: "end_date")
  final String endDate;
  @JsonKey(name: "coupon_dis_price")
  final double? couponDisPrice;
  @JsonKey(name: "is_active")
  final int isActive;
  final String? gift;
  @JsonKey(name: "number_of_coupon")
  final int numberOfCoupon;

  @override
  List<Object?> get props => [
        id,
        couponCode,
        startDate,
        endDate,
        couponDisPrice,
        isActive,
        gift,
        numberOfCoupon
      ];
  Map<String, dynamic> toJson() => _$CouponModelToJson(this);

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);
}
