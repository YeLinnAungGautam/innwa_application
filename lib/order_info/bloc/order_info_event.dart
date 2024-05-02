part of 'order_info_bloc.dart';

class OrderInfoEvent extends Equatable {
  const OrderInfoEvent({required this.context});
  final BuildContext context;

  @override
  List<Object> get props => [];
}

final class GetDeliveryFeeEvent extends OrderInfoEvent {
  const GetDeliveryFeeEvent({required super.context});
}

final class ClickPaymentButtonEvent extends OrderInfoEvent {
  const ClickPaymentButtonEvent({required super.context});
}
