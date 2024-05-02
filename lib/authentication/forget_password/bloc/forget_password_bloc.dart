import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/router_service/router.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/util/ui/snack_bar.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc(this._restAPI) : super(const ForgetPasswordState()) {
    on<SubmitForgetPasswordEvent>(_submitForgetPassword);
  }

  final RestAPI _restAPI;

  final TextEditingController email = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> _submitForgetPassword(
      SubmitForgetPasswordEvent event, Emitter emit) async {
    final bool validate = formKey.currentState!.validate();
    if (validate) {
      emit(state.copyWith(sendStatus: ApiStatus.processing));
      final resData = await _sendForgetPasswordMail(
        data: {
          "email": email.text,
        },
      );
      emit(state.copyWith(sendStatus: ApiStatus.completed));
      if (resData != null) {
        RouterService.of(event.context).pop();
        showSnackBar(
          message: resData["message"],
          title: "Forget Password",
          context: event.context,
          backgroundColor: Colors.green,
          titleColor: Colors.white,
          messageColor: Colors.white,
        );
      } else {
        showSnackBar(
          message: "Something went wrong.Try Again!",
          title: "Forget Password",
          context: event.context,
          backgroundColor: Colors.red,
          titleColor: Colors.white,
          messageColor: Colors.white,
        );
      }
    }
  }

  Future<Map<String, dynamic>?> _sendForgetPasswordMail(
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
      path: ApiKey.forgetPassword,
      error: error,
      data: data,
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
