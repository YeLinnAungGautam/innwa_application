import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/cart/model/coupon_model.dart';

import '../../service/api_service/model.dart';

part 'coupon_event.dart';
part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc(this._restAPI) : super(const CouponState()) {
    on<GetCouponEvent>(_getCouponsEvent);
  }

  final RestAPI _restAPI;

  Future<void> _getCouponsEvent(GetCouponEvent event, Emitter emit) async {
    emit(state.copyWith(couponStatus: ApiStatus.processing));
    final resData = await _getCoupons();
    if (resData != null) {
      if (resData["coupons"] != null) {
        final jsonList = resData["coupons"] as List;
        emit(state.copyWith(
            couponStatus: ApiStatus.completed,
            coupons: jsonList.map((e) => CouponModel.fromJson(e)).toList()));
      } else {
        emit(
          state.copyWith(
            couponStatus: ApiStatus.completed,
            coupons: [],
          ),
        );
      }
    } else {
      emit(state.copyWith(couponStatus: ApiStatus.failure));
    }
  }

  Future<Map<String, dynamic>?> _getCoupons() async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: ApiKey.couponList,
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
