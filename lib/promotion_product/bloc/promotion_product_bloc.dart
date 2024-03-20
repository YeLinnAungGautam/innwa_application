import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/home/latest_phone/model/product_model.dart';

part 'promotion_product_event.dart';
part 'promotion_product_state.dart';

class PromotionProductBloc
    extends Bloc<PromotionProductEvent, PromotionProductState> {
  PromotionProductBloc(this._restAPI) : super(const PromotionProductState()) {
    on<GetPromotionProductEvent>(_getPromotionProductEvent);
  }
  final RestAPI _restAPI;

  Future<void> _getPromotionProductEvent(
    GetPromotionProductEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(productGetState: ApiStatus.processing));
    final resData = await _getProduct(path: ApiKey.latestPhone);
    if (resData != null) {
      final jsonData = resData["latestPhones"] as List;
      final List<ProductModel> data =
          jsonData.map((e) => ProductModel.fromJson(e)).toList();
      emit(state.copyWith(
        productGetState: ApiStatus.completed,
        products: data,
        productImagePath: resData["image_path"],
      ));
    } else {
      emit(state.copyWith(productGetState: ApiStatus.failure));
    }
  }

  Future<Map<String, dynamic>?> _getProduct({required String path}) async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: path,
      error: error,
      timeOutError: error,
      isAlreadyToken: false,
      afterValidate: AfterCallBackConfig(
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
}
