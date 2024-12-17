part of 'order_info_bloc.dart';

class OrderInfoState extends Equatable {
  const OrderInfoState({this.deliveryStatus = ApiStatus.completed});

  final ApiStatus deliveryStatus;

  @override
  List<Object> get props => [deliveryStatus];

  OrderInfoState copyWith({ApiStatus? deliveryStatus}) {
    return OrderInfoState(
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
    );
  }
}
