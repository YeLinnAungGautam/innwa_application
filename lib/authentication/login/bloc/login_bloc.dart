import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  LoginBloc(this._restAPI) : super(const LoginState()) {
    on<UpdateLoginEmailEvent>(_updateLoginEmail);
    on<UpdateLoginPasswordEvent>(_updateLoginPassword);
    on<ClickLoginBtnEvent>(_clickLoginBtn);
    on<GoogleLoginEvent>(_clickGoogleSignInBtn);
  }

  final GlobalKey<FormState> loginKey = GlobalKey();
  final RestAPI _restAPI;

  Future<Map<String, dynamic>?> _loginUser(
      {required Map<String, dynamic> data, String path = ApiKey.login}) async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "POST",
      path: path,
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

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? gAuth = await gUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: gAuth?.idToken,
        accessToken: gAuth?.accessToken,
      );
      return await _auth.signInWithCredential(
        credential,
      );
    } catch (error) {
      print("Google Sign-In error: $error");
      return null;
    }
  }

  Future<void> _clickGoogleSignInBtn(
      GoogleLoginEvent event, Emitter emit) async {
    await _signInWithGoogle().then(
      (gUser) async {
        emit(state.copyWith(sendStatus: ApiStatus.processing));
        if (gUser == null) {
          throw Exception("Firebase user data is incomplete.");
        }

        final resData = await _loginUser(
          path: ApiKey.googleLogin,
          data: {
            "firebase_id": gUser.user?.uid,
            "name": gUser.user?.displayName,
            "email": gUser.user?.email,
          },
        );

        if (resData != null && resData["status"] == "success") {
          emit(state.copyWith(sendStatus: ApiStatus.completed));

          final List<int> wishListProduct =
              (resData["wishlist"]["data"] as List?)
                      ?.map((e) => ((e as Map)["product_id"] as int))
                      .toList() ??
                  [];

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
            )
            ..add(
              UpdateWishListDataEvent(
                  context: event.context, data: wishListProduct),
            );

          BlocProvider.of<AppServiceBloc>(event.context).api.api.myToken =
              resData["token"] ?? "";

          await Future.wait([
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
              data: resData["token"] ?? '',
              key: StorageService.I.authTokenStoreKey,
            ),
            StorageService.I.storeData(
              data: resData["profile_image_path"] ?? '',
              key: StorageService.I.profileImagePath,
            ),
          ]);
          if (event.context.mounted) {
            RouterService.of(event.context).pop();

            showSnackBar(
              message: resData["message"],
              title: "Login Success",
              context: event.context,
              backgroundColor: Colors.green,
              titleColor: Colors.white,
              messageColor: Colors.white,
            );
          }
        } else {
          log(" res data is null");
          if (!event.context.mounted) return;
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
      },
    );
  }

  Future<void> _clickLoginBtn(ClickLoginBtnEvent event, Emitter emit) async {
    final validate = loginKey.currentState!.validate();
    if (validate) {
      emit(state.copyWith(sendStatus: ApiStatus.processing));

      final resData = await _loginUser(
        data: {
          "email": state.email,
          "password": state.password,
        },
      );

      emit(state.copyWith(sendStatus: ApiStatus.completed));
      if (resData != null) {
        final List<int> wishListProduct = (resData["wishlist"]["data"] as List)
            .map((e) => ((e as Map)["product_id"] as int))
            .toList();

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
          )
          ..add(UpdateWishListDataEvent(
              context: event.context, data: wishListProduct));
        await Future.wait([
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
