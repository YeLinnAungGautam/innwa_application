import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/router_service/router.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/_application/service/storage/storage_service.dart';
import 'package:innwa_mobile_dev/cart/model/coupon_model.dart';
import 'package:innwa_mobile_dev/order_info/model/deli_fee_model.dart';
import 'package:innwa_mobile_dev/payment_select/model/payment_model.dart';
import 'package:innwa_mobile_dev/profile/profile_edit/model/state_model.dart';
import 'package:innwa_mobile_dev/profile/profile_edit/model/township_model.dart';
import 'package:innwa_mobile_dev/util/ui/snack_bar.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._restAPI) : super(CartState()) {
    on<UpdateCartStateEvent>(_updateCartStateEvent);
    on<UpdateCartTownshipEvent>(_updateCartTownshipEvent);
    on<ClearCartTownshipEvent>(_clearCartTownship);
    on<UpdateUserCartEvent>(_updateUserCart);
    on<UpdateUserCartFromStorageEvent>(_updateUserCartFromStorage);
    on<DeleteUserCartEvent>(_deleteuserCart);
    on<AddQuantityEvent>(_addQuantity);
    on<ReduceQuantityEvent>(_reduceQty);
    on<UpdateDeliFeeEvent>(_updateDeliFee);
    on<ClickCouponApplyBtnEvent>(_clickCouponApply);
    on<ClearCouponEvent>(_clearCoupon);
    on<SelectPaymentMethodEvent>(_selectPayment);
    on<ClearOrderDataEvent>(_clearOrderData);
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController additionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController couponController = TextEditingController();
  final GlobalKey<FormState> couponFormKey = GlobalKey<FormState>();

  void _clearOrderData(ClearOrderDataEvent event, Emitter emit) {
    nameController.text = "";
    phoneController.text = "";
    emailController.text = "";
    addressController.text = "";
    additionController.text = "";
    emit(state
        .clearCoupon()
        .clearState()
        .clearTownship()
        .clearPayment()
        .copyWith(
      userCart: [],
    ));
    StorageService.I.deleteData(key: StorageService.I.userCart);
  }

  void _selectPayment(SelectPaymentMethodEvent event, Emitter emit) {
    emit(state.copyWith(payment: event.payment));
  }

  void _clearCoupon(ClearCouponEvent event, Emitter emit) {
    emit(state.clearCoupon().copyWith(changeCoupon: !state.changeCoupon));
  }

  Future<void> _clickCouponApply(
    ClickCouponApplyBtnEvent event,
    Emitter emit,
  ) async {
    final validate = couponFormKey.currentState!.validate();
    if (validate) {
      emit(state.copyWith(checkCouponStatus: ApiStatus.processing));
      final List<int> productId = state.userCart
          .map((e) => (e["product_price"]["product_id"] as int))
          .toList();
      final data = {
        "product_id": productId,
        "coupon_code": couponController.text,
      };

      final resData = await _checkCoupon(data: data);

      emit(
        state.copyWith(
          checkCouponStatus: ApiStatus.completed,
        ),
      );

      if (resData != null && resData["coupon"] != null) {
        final CouponModel coupon = CouponModel.fromJson(resData["coupon"]);

        if (coupon.isActive == 1 &&
            coupon.numberOfCoupon > 0 &&
            DateTime.now().isAfter(DateTime.parse(coupon.startDate)) &&
            DateTime.now().isBefore(
              DateTime.parse(coupon.endDate),
            )) {
          emit(state.copyWith(coupon: coupon));
        } else {
          showSnackBar(
            message: "Invalid Coupon Code",
            title: "Coupon Code",
            context: event.context,
            backgroundColor: Colors.amber,
            messageColor: Colors.black,
            titleColor: Colors.black,
          );
        }
        RouterService.of(event.context).pop();
      } else {
        RouterService.of(event.context).pop();
        showSnackBar(
          message: "Invalid Coupon Code",
          title: "Coupon Code",
          context: event.context,
          backgroundColor: Colors.amber,
          messageColor: Colors.black,
          titleColor: Colors.black,
        );
      }
    }

    debugPrint(
        "-----------Click Coupon Apply-----------------------------------------------------");
  }

  Future<Map<String, dynamic>?> _checkCoupon({
    required Map<String, dynamic> data,
  }) async {
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
      path: ApiKey.checkCoupon,
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

  void _updateDeliFee(UpdateDeliFeeEvent event, Emitter emit) {
    emit(state.copyWith(deliFee: event.deliFee));
  }

  void _reduceQty(ReduceQuantityEvent event, Emitter emit) {
    List<Map<String, dynamic>> newList = [...state.userCart];
    debugPrint(
        "-----------Call This Fun---------------------${event.productId}---${event.priceId}-----------------------------");
    newList = newList.map((e) {
      debugPrint(
          "-----------Call ---------------------${e["product_price"]["product_id"]}---${e["product_price"]["id"]}-----------------------------");
      if (e["product_price"]["product_id"] == event.productId &&
          e["product_price"]["id"] == event.priceId) {
        if ((e["quantity"] ?? 0) - 1 < 1) {
          e["quantity"] = 1;
        } else {
          e["quantity"] = ((e["quantity"] ?? 0) - 1);
        }
        debugPrint(
            "-----------e ---------------------$e--------------------------------");
        e = e;
      }
      return e;
    }).toList();
    emit(state
        .copyWith(userCart: [...newList], rebuildCart: !state.rebuildCart));
    StorageService.I.storeData(
        key: StorageService.I.userCart, data: jsonEncode(state.userCart));
  }

  void _addQuantity(AddQuantityEvent event, Emitter emit) {
    List<Map<String, dynamic>> newList = [...state.userCart];
    newList = newList.map((e) {
      if (e["product_price"]["product_id"] == event.productId &&
          e["product_price"]["id"] == event.priceId) {
        if ((e["quantity"] ?? 0) + 1 <
            int.tryParse(e["product_price"]["stock_qty"] ?? "1")) {
          e["quantity"] = (e["quantity"] ?? 0) + 1;
        } else {
          e["quantity"] = int.tryParse(e["product_price"]["stock_qty"]);
        }
        debugPrint(
            "-----------e ---------------------$e--------------------------------");
        e = e;
      }
      return e;
    }).toList();
    emit(state
        .copyWith(userCart: [...newList], rebuildCart: !state.rebuildCart));
    StorageService.I.storeData(
        key: StorageService.I.userCart, data: jsonEncode(state.userCart));
  }

  void _deleteuserCart(DeleteUserCartEvent event, Emitter emit) {
    List<Map<String, dynamic>> newList = [...state.userCart];

    newList = newList
        .where((element) =>
            element["product_price"]["product_id"] != event.productId &&
            element["product_price"]["id"] != event.priceId)
        .toList();
    emit(state.copyWith(userCart: newList));
    StorageService.I.storeData(
        key: StorageService.I.userCart, data: jsonEncode(state.userCart));
  }

  void _updateUserCartFromStorage(
      UpdateUserCartFromStorageEvent event, Emitter emit) {
    emit(state.copyWith(userCart: event.data));
  }

  void _updateUserCart(UpdateUserCartEvent event, Emitter emit) {
    if (state.userCart.isEmpty) {
      emit(state.copyWith(userCart: [event.data]));
    } else {
      debugPrint(
          "-----------This is call Top 0-----------------------------------------------------");
      if (int.tryParse(event.data["product_price"]["stock_qty"] ?? "0") != 0) {
        debugPrint(
            "-----------This is call Top-----------------------------------------------------");
        final filterData = state.userCart.where((element) =>
            element["product_price"]["product_id"] ==
                event.data["product_price"]["product_id"] &&
            element["product_price"]["id"] ==
                event.data["product_price"]["id"]);
        if (filterData.isNotEmpty) {
          List<Map<String, dynamic>> newList = [...state.userCart];
          newList = newList.map((e) {
            if (e["product_price"]["product_id"] ==
                    event.data["product_price"]["product_id"] &&
                e["product_price"]["id"] == event.data["product_price"]["id"]) {
              if ((e["quantity"] ?? 0) + 1 <
                  int.tryParse(
                      event.data["product_price"]["stock_qty"] ?? "1")) {
                e["quantity"] = (e["quantity"] ?? 0) + 1;
              } else {
                e["quantity"] =
                    int.tryParse(event.data["product_price"]["stock_qty"]);
              }
              e = e;
            }
            return e;
          }).toList();
          emit(state.copyWith(userCart: [...newList]));
        } else {
          emit(state.copyWith(userCart: [...state.userCart, event.data]));
        }
      } else {
        showSnackBar(
          message: "Out of stock",
          title: "Select Specification",
          context: event.context,
          titleColor: Colors.black,
          messageColor: Colors.black,
          backgroundColor: Colors.amber,
        );
      }
    }
    StorageService.I.storeData(
        key: StorageService.I.userCart, data: jsonEncode(state.userCart));
  }

  void _clearCartTownship(ClearCartTownshipEvent event, Emitter emit) {
    emit(state.clearTownship().copyWith(stateChange: !state.stateChange));
  }

  void _updateCartTownshipEvent(UpdateCartTownshipEvent event, Emitter emit) {
    emit(state.copyWith(selectedTownship: event.data));
  }

  void _updateCartStateEvent(UpdateCartStateEvent event, Emitter emit) {
    debugPrint(
        "-----------Update SelectedState---------------------${event.data}--------------------------------");
    emit(state.copyWith(selectedState: event.data));
  }

  final RestAPI _restAPI;
}
