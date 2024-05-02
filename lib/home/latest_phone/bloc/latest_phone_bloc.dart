import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/home/latest_phone/model/product_model.dart';

part 'latest_phone_event.dart';
part 'latest_phone_state.dart';

class LatestPhoneBloc extends Bloc<LatestPhoneEvent, LatestPhoneState> {
  LatestPhoneBloc(this._restAPI) : super(const LatestPhoneState()) {
    on<GetLatestPhoneEvent>(_getLatestPhoneEvent);
    on<GetLatestComputerEvent>(_getLatestComputer);
    on<GetLatestLaptopEvent>(_getLatestLaptop);
    on<GetPromotionProductEvent>(_getPromotionProductEvent);
  }
  final RestAPI _restAPI;

  Future<void> _getPromotionProductEvent(
    GetPromotionProductEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(productGetState: ApiStatus.processing));
    final resData = await _getProduct(path: ApiKey.promotionProduct);
    if (resData != null) {
      if (resData["promotionProducts"] != null) {
        final jsonData = resData["promotionProducts"] as List;
        final List<ProductModel> data =
            jsonData.map((e) => ProductModel.fromJson(e)).toList();
        emit(state.copyWith(
          productGetState: ApiStatus.completed,
          products: data,
          productImagePath: resData["image_path"],
        ));
      } else {
        emit(state.copyWith(
          productGetState: ApiStatus.completed,
          products: [],
        ));
      }
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

  Future<void> _getLatestLaptop(
      GetLatestLaptopEvent event, Emitter emit) async {
    emit(state.copyWith(computerGetState: ApiStatus.processing));
    final resData = await _getlatest(path: ApiKey.latestLaptop);
    if (resData != null) {
      if (resData["latestLaptops"] != null) {
        final jsonData = resData["latestLaptops"] as List;
        final List<ProductModel> data =
            jsonData.map((e) => ProductModel.fromJson(e)).toList();
        emit(state.copyWith(
          laptopGetState: ApiStatus.completed,
          latestLaptop: data,
          laptopImagePath: resData["image_path"],
        ));
      } else {
        emit(state.copyWith(
          laptopGetState: ApiStatus.completed,
          latestLaptop: [],
        ));
      }
    } else {
      emit(state.copyWith(laptopGetState: ApiStatus.failure));
    }
  }

  Future<void> _getLatestComputer(
      GetLatestComputerEvent event, Emitter emit) async {
    emit(state.copyWith(computerGetState: ApiStatus.processing));
    final resData = await _getlatest(path: ApiKey.latestComputer);
    if (resData != null) {
      if (resData["latestComputers"] != null) {
        final jsonData = resData["latestComputers"] as List;
        final List<ProductModel> data =
            jsonData.map((e) => ProductModel.fromJson(e)).toList();
        emit(state.copyWith(
          computerGetState: ApiStatus.completed,
          latestComputer: data,
          computeImagePath: resData["image_path"],
        ));
      } else {
        emit(state.copyWith(
          computerGetState: ApiStatus.completed,
          latestComputer: [],
        ));
      }
    } else {
      emit(state.copyWith(computerGetState: ApiStatus.failure));
    }
  }

  Future<void> _getLatestPhoneEvent(
      GetLatestPhoneEvent event, Emitter emit) async {
    emit(state.copyWith(getState: ApiStatus.processing));
    final resData = await _getlatest(path: ApiKey.latestPhone);
    if (resData != null) {
      if (resData["latestPhones"] != null) {
        final jsonData = resData["latestPhones"] as List;
        final List<ProductModel> data =
            jsonData.map((e) => ProductModel.fromJson(e)).toList();
        emit(state.copyWith(
          getState: ApiStatus.completed,
          latestPhones: data,
          imagePath: resData["image_path"],
        ));
      } else {
        emit(state.copyWith(
          getState: ApiStatus.completed,
          latestPhones: [],
        ));
      }
    } else {
      emit(state.copyWith(getState: ApiStatus.failure));
    }
  }

  Future<Map<String, dynamic>?> _getlatest({required String path}) async {
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
