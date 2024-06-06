import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_path.dart';
import 'package:innwa_mobile_dev/_application/router_service/router.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/cart/bloc/cart_bloc.dart';
import 'package:innwa_mobile_dev/payment_select/model/payment_model.dart';
import 'package:innwa_mobile_dev/product_details/model/product_details_model.dart';
import 'package:innwa_mobile_dev/util/ui/innwa_loading.dart';
import 'package:innwa_mobile_dev/util/ui/snack_bar.dart';

part 'payment_select_event.dart';
part 'payment_select_state.dart';

class PaymentSelectBloc extends Bloc<PaymentSelectEvent, PaymentSelectState> {
  PaymentSelectBloc(this._restAPI) : super(const PaymentSelectState()) {
    on<GetPaymentMethodEvent>(_getPaymentMethodEvent);
    on<ClickOrderBtnEvent>(_clickOrderBtn);
  }
  final RestAPI _restAPI;

  Future<void> _clickOrderBtn(ClickOrderBtnEvent event, Emitter emit) async {
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(event.context);
    if (cartBloc.state.payment == null) {
      showSnackBar(
        message: "You need to select the payment.",
        title: "Payment Select",
        context: event.context,
        backgroundColor: Colors.amber,
        messageColor: Colors.black,
        titleColor: Colors.black,
      );
    } else {
      final innwaLoading = InnwaLoading(context: event.context)
        ..showLoadingSpinner();
      double subTotal = 0;

      for (var cart in cartBloc.state.userCart) {
        final ProductDetailsPriceModel price =
            ProductDetailsPriceModel.fromJson(cart["product_price"]);
        subTotal += (price.price.toDouble() -
                double.parse(price.disPrice ?? "0.0") -
                double.parse(
                  price.cashback ?? "0",
                ) -
                (cartBloc.state.coupon?.couponDisPrice ?? 0)) *
            cart["quantity"];
      }

      final sendData = {
        "payment_id": cartBloc.state.payment!.id,
        "items": cartBloc.state.userCart.map((e) {
          e["product_price"]["product_price_id"] = e["product_price"]["id"];
          e = e;
          return e;
        }).toList(),
        "state_id": cartBloc.state.selectedState!.id,
        "township_id": cartBloc.state.selectedTownship!.id,
        "phone": "09${cartBloc.phoneController.text}",
        "coupon_code": cartBloc.state.coupon?.couponCode,
        "name": cartBloc.nameController.text,
        "email": cartBloc.emailController.text,
        "address": cartBloc.addressController.text,
        "addition": cartBloc.additionController.text,
        "sub_total":
            subTotal + double.parse(cartBloc.state.deliFee?.fee ?? "0"),
      };
      final resData = await _order(data: sendData);
      innwaLoading.closeLoadingSpinner();
      if (resData != null) {
        if (resData["status"] == "error") {
          showSnackBar(
            message: resData["message"] ?? "",
            title: "Order Error",
            context: event.context,
            backgroundColor: Colors.amber,
            messageColor: Colors.black,
            titleColor: Colors.black,
          );
        } else {
          showSnackBar(
            message: resData["message"] ?? "",
            title: "Order",
            context: event.context,
            backgroundColor: Colors.green,
            messageColor: Colors.black,
            titleColor: Colors.black,
          );
          cartBloc.add(ClearOrderDataEvent(context: event.context));
          RouterService.of(event.context)
              .push(RouterPath.I.home.fullPath, redirect: true);
        }
      }
      debugPrint(
          "-----------Go To Server------$sendData-----------------------------------------------");
    }
  }

  Future<Map<String, dynamic>?> _order(
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
      path: ApiKey.order,
      error: error,
      data: data,
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

  Future<void> _getPaymentMethodEvent(
    GetPaymentMethodEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(paymentGetStatus: ApiStatus.processing));
    final resData = await _getpayments();
    if (resData != null) {
      final jsonData = resData["payments"] as List;
      final List<PaymentModel> data =
          jsonData.map((e) => PaymentModel.fromJson(e)).toList();
      emit(state.copyWith(
          paymentGetStatus: ApiStatus.completed, payments: data));
    } else {
      emit(state.copyWith(paymentGetStatus: ApiStatus.failure));
    }
  }

  Future<Map<String, dynamic>?> _getpayments() async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: ApiKey.paymentMethod,
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
