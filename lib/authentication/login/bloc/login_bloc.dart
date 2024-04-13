import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/router_service/router.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/_application/service/storage/storage_service.dart';
import 'package:innwa_mobile_dev/user/bloc/user_bloc.dart';
import 'package:innwa_mobile_dev/user/model/user_model.dart';
import 'package:innwa_mobile_dev/util/ui/snack_bar.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._restAPI) : super(const LoginState()) {
    on<UpdateLoginEmailEvent>(_updateLoginEmail);
    on<UpdateLoginPasswordEvent>(_updateLoginPassword);
    on<ClickLoginBtnEvent>(_clickLoginBtn);
  }

  final GlobalKey<FormState> loginKey = GlobalKey();
  final RestAPI _restAPI;

  Future<Map<String, dynamic>?> _loginUser(
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
      path: ApiKey.login,
      data: data,
      error: error,
      timeOutError: error,
      isAlreadyToken: false,
      afterValidate: AfterCallBackConfig(
          allowBoth: true,
          onCallBack: (value, result) async {
            if (!result!) {
              resData = value;
            }
            return result;
          }),
      onSuccess: (value) async {
        resData = value;
      },
    );
    return resData;
  }

  void _updateLoginEmail(UpdateLoginEmailEvent event, Emitter emit) {
    emit(state.copyWith(email: event.data));
  }

  void _updateLoginPassword(UpdateLoginPasswordEvent event, Emitter emit) {
    emit(state.copyWith(password: event.data));
  }

  Future<void> _clickLoginBtn(ClickLoginBtnEvent event, Emitter emit) async {
    final validate = loginKey.currentState!.validate();
    if (validate) {
      emit(state.copyWith(sendStatus: ApiStatus.processing));

      final resData = await _loginUser(data: {
        "email": state.email,
        "password": state.password,
      });

      emit(state.copyWith(sendStatus: ApiStatus.completed));
      if (resData != null) {
        BlocProvider.of<UserBloc>(event.context)
          ..add(
            UpdateUserDataEvent(
              context: event.context,
              user: UserModel.fromJson(
                resData["customer"],
              ),
            ),
          )
          ..add(
            UpdateProfileImagePathEvent(
              context: event.context,
              data: resData["profile_image_path"] + "/",
            ),
          );
        Future.wait([
          StorageService.I.storeData(
            data: jsonEncode(UserModel.fromJson(
              resData["customer"],
            ).toJson()),
            key: StorageService.I.loginDataStoreKey,
          ),
          StorageService.I.storeData(
            data: DateTime.now().add(const Duration(days: 7)).toString(),
            key: StorageService.I.loginExpireTime,
          ),
          StorageService.I.storeData(
            data: resData["token"],
            key: StorageService.I.authTokenStoreKey,
          ),
          StorageService.I.storeData(
            data: resData["profile_image_path"],
            key: StorageService.I.profileImagePath,
          ),
        ]);

        BlocProvider.of<AppServiceBloc>(event.context).api.api.myToken =
            resData["token"];
        RouterService.of(event.context).pop();

        showSnackBar(
          message: resData["message"],
          title: "Login Success",
          context: event.context,
          backgroundColor: Colors.green,
          titleColor: Colors.white,
          messageColor: Colors.white,
        );
      } else {
        showSnackBar(
          message:
              "Wrong Credentials (or) Your Email Isn't Register To System!",
          title: "Login Error",
          context: event.context,
          backgroundColor: Colors.red,
          titleColor: Colors.white,
          messageColor: Colors.white,
        );
      }
    }
  }
}
