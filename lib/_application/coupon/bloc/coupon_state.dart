part of 'coupon_bloc.dart';

class CouponState extends Equatable {
  const CouponState(
      {this.couponStatus = ApiStatus.completed, this.coupons = const []});
  final ApiStatus couponStatus;
  final List<CouponModel> coupons;

  @override
  List<Object> get props => [couponStatus, coupons];

  CouponState copyWith({ApiStatus? couponStatus, List<CouponModel>? coupons}) {
    return CouponState(
      couponStatus: couponStatus ?? this.couponStatus,
      coupons: coupons ?? this.coupons,
    );
  }
}
