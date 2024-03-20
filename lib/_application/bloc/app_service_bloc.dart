import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/model/site_setting_model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';

part 'app_service_event.dart';
part 'app_service_state.dart';

class AppServiceBloc extends Bloc<AppServiceEvent, AppServiceState> {
  AppServiceBloc({required this.api}) : super(const AppServiceState()) {
    on<GetSitemodelEvent>(_getSiteModelEvent);
  }
  final RestAPI api;

  Future<void> _getSiteModelEvent(
    GetSitemodelEvent event,
    Emitter emit,
  ) async {
    final resData = await _getSite();

    if (resData == null) {
      event.completer.complete(false);
    } else {
      emit(state.copyWith(site: SiteModel.fromJson(resData)));
      event.completer.complete(true);
    }
  }

  Future<Map<String, dynamic>?> _getSite() async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await api.api.query<Map<String, dynamic>>(
      method: "GET",
      path: ApiKey.siteSetting,
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
