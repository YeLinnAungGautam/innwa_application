import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/home/home_banner/model/brand_model.dart';
import 'package:innwa_mobile_dev/home/home_banner/model/slider_model.dart';
import 'package:innwa_mobile_dev/home/home_banner/model/sub_banner_model.dart';

part 'home_banner_event.dart';
part 'home_banner_state.dart';

class HomeBannerBloc extends Bloc<HomeBannerEvent, HomeBannerState> {
  HomeBannerBloc(this._restAPI) : super(const HomeBannerState()) {
    on<GetHomeBannerEvent>(_getHomeBannerEvent);
    on<GetHomeSubBannerEvent>(_getHomeSubBannerEvent);
    on<GetBrandEvent>(_getBrandsEvent);
  }

  final RestAPI _restAPI;

  Future<void> _getBrandsEvent(GetBrandEvent event, Emitter emit) async {
    final resData = await _getBrands();
    if (resData != null) {
      final jsonList = resData["brandSliders"] as List;
      final data = jsonList.map((e) => BrandModel.fromJson(e)).toList();
      emit(
        state.copyWith(
          brandPath: resData["slider_image_path"],
          brands: data,
        ),
      );
    }
  }

  Future<Map<String, dynamic>?> _getBrands() async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: ApiKey.brand,
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

  Future<void> _getHomeSubBannerEvent(
      GetHomeSubBannerEvent event, Emitter emit) async {
    final resData = await _getHomeSubBanner();
    if (resData != null) {
      final jsonList = resData["sub_banners"] as List;
      final data = jsonList.map((e) => SubBannerModel.fromJson(e)).toList();
      emit(
        state.copyWith(
          subBannerImagePath: resData["banner_image_path"],
          subBanners: data,
        ),
      );
    }
  }

  Future<Map<String, dynamic>?> _getHomeSubBanner() async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: ApiKey.subBanner,
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

  Future<Map<String, dynamic>?> _getHomeBanner() async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: ApiKey.slider,
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

  Future<void> _getHomeBannerEvent(
      GetHomeBannerEvent event, Emitter emit) async {
    final resData = await _getHomeBanner();
    if (resData != null) {
      final jsonList = resData["sliders"] as List;
      final data = jsonList.map((e) => SliderModel.fromJson(e)).toList();
      emit(
        state.copyWith(
          imagePath: resData["slider_image_path"],
          sliders: data,
        ),
      );
      event.completer.complete(true);
    } else {
      event.completer.complete(false);
    }
  }
}
