import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/router_service/router_service.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/order/order_history/model/order_history_model.dart';
import 'package:innwa_mobile_dev/order/order_history/widgets/status_select_ui.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  OrderHistoryBloc(this._restAPI) : super(const OrderHistoryState()) {
    on<UpdateSelectedTabEvent>(_updateSelectedTab);
    on<GetOrderHistoryEvent>(_getOrderHistory);
    on<GetPendingOrderEvent>(_getPendingOrder);
    on<SelectOrderStatusEvent>(_selectOrderStatusEvent);
  }

  final RestAPI _restAPI;
  final List<Map<String, dynamic>> orderStatus = [
    {
      "value": "in-progress",
      "key": "In Progress",
      "mmkey": "လုပ်ဆောင်နေဆဲ",
    },
    {
      "value": "approved",
      "key": "Approved",
      "mmkey": "အတည်ပြုပြီး",
    },
    {
      "value": "cancelled",
      "key": "Cancelled",
      "mmkey": "ဖျက်သိမ်းလိုက်သည်။",
    },
    {
      "value": "failed",
      "key": "Failed",
      "mmkey": "မအောင်မြင်",
    },
    {
      "value": "completed",
      "key": "Completed",
      "mmkey": "ပြီးဆုံး",
    },
  ];

  void _selectOrderStatusEvent(SelectOrderStatusEvent event, Emitter emit) {
    if (event.data["value"] != state.selectedType["value"]) {
      RouterService.of(event.context).pop();
      emit(state.copyWith(selectedType: event.data));
      add(GetPendingOrderEvent(context: event.context));
    }
  }

  Future<void> _getOrderHistory(
      GetOrderHistoryEvent event, Emitter emit) async {
    emit(state.copyWith(historyStatus: ApiStatus.processing));
    final resData = await _getOrders();

    if (resData != null) {
      if (resData["orders"] != null) {
        final jsonList = resData["orders"] as List;
        final List<OrderHistoryModel> data =
            jsonList.map((e) => OrderHistoryModel.fromJson(e)).toList();
        emit(state.copyWith(
          historyStatus: ApiStatus.completed,
          orderHistory: data,
        ));
      } else {
        emit(state.copyWith(
          historyStatus: ApiStatus.completed,
          orderHistory: [],
        ));
      }
    } else {
      emit(state.copyWith(historyStatus: ApiStatus.failure));
    }
  }

  Future<void> _getPendingOrder(
      GetPendingOrderEvent event, Emitter emit) async {
    emit(state.copyWith(pendingStatus: ApiStatus.processing));
    final resData =
        await _filterOrder(data: {"order_status": state.selectedType['value']});

    if (resData != null) {
      if (resData["orders"] != null) {
        final jsonList = resData["orders"] as List;
        final List<OrderHistoryModel> data =
            jsonList.map((e) => OrderHistoryModel.fromJson(e)).toList();
        emit(
          state.copyWith(
            pendingStatus: ApiStatus.completed,
            orderPending: data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            pendingStatus: ApiStatus.completed,
            orderPending: [],
          ),
        );
      }
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

  Future<Map<String, dynamic>?> _filterOrder(
      {required Map<String, dynamic> data}) async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "POST",
      data: data,
      path: ApiKey.orderFilter,
      error: error,
      timeOutError: error,
      afterValidate: AfterCallBackConfig(
        allowBoth: true,
        onCallBack: (value, result) async {
          if (!result!) {
            resData = null;
          }
          return result;
        },
      ),
      onSuccess: (value) async {
        resData = value;
      },
    );
    return resData;
  }

  Future<void> _updateSelectedTab(
      UpdateSelectedTabEvent event, Emitter emit) async {
    if (event.selectedTab == 1 && state.selectedTab == 1) {
      await showModalBottomSheet(
        context: event.context,
        builder: (ctx) {
          return BlocProvider.value(
            value: BlocProvider.of<OrderHistoryBloc>(event.context),
            child: const StatusSelectUi(),
          );
        },
      );
      debugPrint(
          "-----------Do Smt plz-----------------------------------------------------");
    } else {
      emit(state.copyWith(selectedTab: event.selectedTab));
    }
  }
}
