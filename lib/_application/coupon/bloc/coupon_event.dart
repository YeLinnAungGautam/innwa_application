part of 'coupon_bloc.dart';

sealed class CouponEvent extends Equatable {
  const CouponEvent({required this.context});
  final BuildContext context;

  @override
  List<Object> get props => [];
}

final class GetCouponEvent extends CouponEvent {
  const GetCouponEvent({required super.context});
}
