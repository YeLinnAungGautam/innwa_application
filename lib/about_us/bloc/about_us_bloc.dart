import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/about_us/model/about_us_model.dart';
import 'package:innwa_mobile_dev/about_us/model/branch_model.dart';

part 'about_us_event.dart';
part 'about_us_state.dart';

class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState> {
  AboutUsBloc(this._restAPI) : super(const AboutUsState()) {
    on<GetBranchEvent>(_getBranchEvent);
    on<GetAboutUsEvent>(_getAboutUsEvent);
  }

  final RestAPI _restAPI;

  Future<void> _getAboutUsEvent(GetAboutUsEvent event, Emitter emit) async {
    emit(state.copyWith(aboutUsStatus: ApiStatus.processing));
    final resData = await _getAboutUs();
    if (resData != null) {
      emit(state.copyWith(
          aboutUsStatus: ApiStatus.completed,
          aboutUs: AboutUsModel.fromJson(resData["about"])));
    } else {
      emit(state.copyWith(aboutUsStatus: ApiStatus.failure));
    }
  }

  Future<Map<String, dynamic>?> _getAboutUs() async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: ApiKey.aboutUs,
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

  Future<void> _getBranchEvent(GetBranchEvent event, Emitter emit) async {
    emit(state.copyWith(branchStatus: ApiStatus.processing));
    // final resData = await _getBranchs();
    await Future.delayed(const Duration(seconds: 2));
    final resData = {};
    emit(state.copyWith(branchStatus: ApiStatus.completed));

    // final jsonData = resData["branches"] as List;
    // final List<BranchModel> branches =
    //     jsonData.map((e) => BranchModel.fromJson(e)).toList();

    // emit(state.copyWith(
    //   branchStatus: ApiStatus.completed,
    //   branchImagePath: resData["branch_image_path"],
    //   branches: branches,
    // ));
  }

  Future<Map<String, dynamic>?> _getBranches() async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: ApiKey.branches,
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
