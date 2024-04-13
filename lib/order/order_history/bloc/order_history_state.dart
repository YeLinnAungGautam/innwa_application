part of 'order_history_bloc.dart';

class OrderHistoryState extends Equatable {
  const OrderHistoryState({
    this.selectedTab = 0,
    this.orderHistory = const [],
    this.orderPending = const [],
    this.historyStatus = ApiStatus.processing,
    this.pendingStatus = ApiStatus.processing,
  });

  final int selectedTab;
  final ApiStatus historyStatus;
  final List<OrderHistoryModel> orderHistory;
  final List<OrderHistoryModel> orderPending;
  final ApiStatus pendingStatus;

  @override
  List<Object> get props => [
        selectedTab,
        orderHistory,
        orderPending,
        historyStatus,
        pendingStatus,
      ];

  OrderHistoryState copyWith({
    int? selectedTab,
    List<OrderHistoryModel>? orderHistory,
    List<OrderHistoryModel>? orderPending,
    ApiStatus? historyStatus,
    ApiStatus? pendingStatus,
  }) {
    return OrderHistoryState(
      selectedTab: selectedTab ?? this.selectedTab,
      orderHistory: orderHistory ?? this.orderHistory,
      orderPending: orderPending ?? this.orderPending,
      historyStatus: historyStatus ?? this.historyStatus,
      pendingStatus: pendingStatus ?? this.pendingStatus,
    );
  }
}
