import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/order/order_history/model/order_history_model.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  OrderHistoryBloc(this._restAPI) : super(const OrderHistoryState()) {
    on<UpdateSelectedTabEvent>(_updateSelectedTab);
    on<GetOrderHistoryEvent>(_getOrderHistory);
    on<GetPendingOrderEvent>(_getPendingOrder);
  }

  final RestAPI _restAPI;

  Future<void> _getOrderHistory(
      GetOrderHistoryEvent event, Emitter emit) async {
    emit(state.copyWith(historyStatus: ApiStatus.processing));
    final resData = await _getOrders();

    if (resData != null) {
      final jsonList = resData["orders"] as List;
      final List<OrderHistoryModel> data =
          jsonList.map((e) => OrderHistoryModel.fromJson(e)).toList();
      emit(state.copyWith(
        historyStatus: ApiStatus.completed,
        orderHistory: data,
      ));
    } else {
      emit(state.copyWith(historyStatus: ApiStatus.failure));
    }
  }

  Future<void> _getPendingOrder(
      GetPendingOrderEvent event, Emitter emit) async {
    emit(state.copyWith(pendingStatus: ApiStatus.processing));
    final resData = await _getOrders();

    if (resData != null) {
      final jsonList = resData["orders"] as List;
      final List<OrderHistoryModel> data =
          jsonList.map((e) => OrderHistoryModel.fromJson(e)).toList();
      emit(state.copyWith(
        pendingStatus: ApiStatus.completed,
        orderPending: data,
      ));
    } else {
      emit(state.copyWith(pendingStatus: ApiStatus.failure));
    }
  }

  Future<Map<String, dynamic>?> _getOrders() async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: ApiKey.customerOrder,
      error: error,
      timeOutError: error,
      afterValidate: AfterCallBackConfig(
          allowBoth: true,
          onCallBack: (value, result) async {
            if (!result!) {
              resData = null;
            }
            return result;
          }),
      onSuccess: (value) async {
        resData = value;
      },
    );
    return resData;
  }

  void _updateSelectedTab(UpdateSelectedTabEvent event, Emitter emit) {
    emit(state.copyWith(selectedTab: event.selectedTab));
  }
}
