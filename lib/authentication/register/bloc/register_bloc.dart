import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/router_service/router.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/util/ui/snack_bar.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this._restAPI) : super(const RegisterState()) {
    on<ClickRegisteBtnEvent>(_clickRegister);
    on<UpdateNameEvent>(_updateName);
    on<UpdateEmailEvent>(_updateEmail);
    on<UpdatePasswordEvent>(_updatePassword);
    on<UpdateConfirmPasswordEvent>(_updateConfirmPassword);
  }
  final RestAPI _restAPI;
  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  void _updateName(UpdateNameEvent event, Emitter emit) {
    emit(state.copyWith(name: event.data));
  }

  void _updateEmail(UpdateEmailEvent event, Emitter emit) {
    emit(state.copyWith(email: event.data));
  }

  void _updatePassword(UpdatePasswordEvent event, Emitter emit) {
    emit(state.copyWith(password: event.data));
  }

  void _updateConfirmPassword(UpdateConfirmPasswordEvent event, Emitter emit) {
    emit(state.copyWith(confirmPassword: event.data));
  }

  Future<Map<String, dynamic>?> _registerUser(
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
      path: ApiKey.register,
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

  Future<void> _clickRegister(ClickRegisteBtnEvent event, Emitter emit) async {
    final bool validate = registerKey.currentState!.validate();
    if (validate) {
      emit(state.copyWith(sendStatus: ApiStatus.processing));
      final resData = await _registerUser(data: {
        "name": state.name,
        "email": state.email,
        "password": state.password,
        "password_confirmation": state.confirmPassword,
      });
      emit(state.copyWith(sendStatus: ApiStatus.completed));
      if (resData != null) {
        RouterService.of(event.context).pop();
        showSnackBar(
          message: resData["message"],
          title: "Register Success",
          context: event.context,
          backgroundColor: Colors.green,
          titleColor: Colors.white,
          messageColor: Colors.white,
        );
      } else {
        showSnackBar(
          message: "Please Check Your Data And Try Again!",
          title: "Register Error",
          context: event.context,
          backgroundColor: Colors.red,
          titleColor: Colors.white,
          messageColor: Colors.white,
        );
      }
    }
  }
}
