part of 'order_history_bloc.dart';

sealed class OrderHistoryEvent extends Equatable {
  const OrderHistoryEvent({required this.context});
  final BuildContext context;
  @override
  List<Object> get props => [];
}

final class UpdateSelectedTabEvent extends OrderHistoryEvent {
  const UpdateSelectedTabEvent(
      {required this.selectedTab, required super.context});
  final int selectedTab;
}

final class GetOrderHistoryEvent extends OrderHistoryEvent {
  const GetOrderHistoryEvent({required super.context});
}

final class GetPendingOrderEvent extends OrderHistoryEvent {
  const GetPendingOrderEvent({required super.context});
}
