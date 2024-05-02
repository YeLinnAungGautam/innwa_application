part of 'order_history_bloc.dart';

class OrderHistoryState extends Equatable {
  const OrderHistoryState({
    this.selectedTab = 0,
    this.orderHistory = const [],
    this.orderPending = const [],
    this.historyStatus = ApiStatus.processing,
    this.pendingStatus = ApiStatus.processing,
    this.selectedType = const {
      "value": "in-progress",
      "key": "In Progress",
      "mmkey": "လုပ်ဆောင်နေဆဲ",
    },
  });

  final int selectedTab;
  final ApiStatus historyStatus;
  final List<OrderHistoryModel> orderHistory;
  final List<OrderHistoryModel> orderPending;
  final ApiStatus pendingStatus;
  final Map<String, dynamic> selectedType;

  @override
  List<Object> get props => [
        selectedTab,
        orderHistory,
        orderPending,
        historyStatus,
        pendingStatus,
        selectedType,
      ];

  OrderHistoryState copyWith({
    int? selectedTab,
    List<OrderHistoryModel>? orderHistory,
    List<OrderHistoryModel>? orderPending,
    ApiStatus? historyStatus,
    ApiStatus? pendingStatus,
    Map<String, dynamic>? selectedType,
  }) {
    return OrderHistoryState(
      selectedTab: selectedTab ?? this.selectedTab,
      orderHistory: orderHistory ?? this.orderHistory,
      orderPending: orderPending ?? this.orderPending,
      historyStatus: historyStatus ?? this.historyStatus,
      pendingStatus: pendingStatus ?? this.pendingStatus,
      selectedType: selectedType ?? this.selectedType,
    );
  }
}
