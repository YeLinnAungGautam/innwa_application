import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_path.dart';
import 'package:innwa_mobile_dev/_application/router_service/router.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/cart/bloc/cart_bloc.dart';
import 'package:innwa_mobile_dev/util/ui/snack_bar.dart';

import '../model/deli_fee_model.dart';

part 'order_info_event.dart';
part 'order_info_state.dart';

class OrderInfoBloc extends Bloc<OrderInfoEvent, OrderInfoState> {
  OrderInfoBloc(this._restAPI) : super(const OrderInfoState()) {
    on<GetDeliveryFeeEvent>(_getDeliFeeEvent);
    on<ClickPaymentButtonEvent>(_clickPaymentBtn);
  }

  final RestAPI _restAPI;

  Future<void> _clickPaymentBtn(
      ClickPaymentButtonEvent event, Emitter emit) async {
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(event.context);
    if (cartBloc.state.deliFee == null) {
      showSnackBar(
        message: "You need to get the delivery fees first.",
        title: "Delivery Fee",
        context: event.context,
        backgroundColor: Colors.amber,
        messageColor: Colors.black,
        titleColor: Colors.black,
      );
    } else {
      await RouterService.of(event.context)
          .push(RouterPath.I.paymentSelect.fullPath);
    }
  }

  Future<void> _getDeliFeeEvent(
    GetDeliveryFeeEvent event,
    Emitter emit,
  ) async {
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(event.context);
    emit(state.copyWith(deliveryStatus: ApiStatus.processing));
    final resData =
        await _getDeliFees(townshipId: cartBloc.state.selectedTownship!.id);
    if (resData != null) {
      final jsonData = resData["fee"] as List;
      if (jsonData.isNotEmpty) {
        cartBloc.add(UpdateDeliFeeEvent(
            context: event.context,
            deliFee: DeliFeeModel.fromJson(jsonData.first)));
      }
      emit(state.copyWith(deliveryStatus: ApiStatus.completed));
    } else {
      emit(state.copyWith(deliveryStatus: ApiStatus.failure));
    }
    debugPrint(
        "-----------Data is---------------------$resData--------------------------------");
  }

  Future<Map<String, dynamic>?> _getDeliFees({required int townshipId}) async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: "${ApiKey.deliFee}/$townshipId",
      error: error,
      timeOutError: error,
      isAlreadyToken: false,
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
}
