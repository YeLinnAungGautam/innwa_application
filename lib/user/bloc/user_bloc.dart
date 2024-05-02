import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/router_service/router.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/_application/service/storage/storage_service.dart';
import 'package:innwa_mobile_dev/user/model/user_model.dart';
import 'package:innwa_mobile_dev/util/ui/snack_bar.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._restAPI) : super(UserState()) {
    on<UpdateUserDataEvent>(_updateUser);
    on<UpdateProfileImagePathEvent>(_updateProfileImagepath);
    on<LogoutEvent>(_logoutEvent);
    on<UpdateWishListDataEvent>(_updateWishListData);
    on<RemoveOrAddWishlistEvent>(_removeOrAddWishlist);
  }

  final RestAPI _restAPI;

  void _removeOrAddWishlist(RemoveOrAddWishlistEvent event, Emitter emit) {
    final bool contain = state.wishlistProductId.contains(event.id);
    debugPrint(
        "-----------contain---------------------$contain--------------------------------");

    if (contain) {
      debugPrint(
          "-----------contain---------------------${state.wishlistProductId}-${event.id}-------------------------------");
      final List<int> newList = [...state.wishlistProductId];
      newList.removeWhere((element) => element == event.id);
      debugPrint(
          "-----------contain---------------------$newList--------------------------------");
      emit(state.copyWith(wishlistProductId: newList));
    } else {
      emit(state
          .copyWith(wishlistProductId: [...state.wishlistProductId, event.id]));
    }
  }

  void _updateWishListData(UpdateWishListDataEvent event, Emitter emit) {
    emit(state.copyWith(wishlistProductId: event.data));
  }

  Future<void> _logoutEvent(LogoutEvent event, Emitter emit) async {
    await Future.wait([
      StorageService.I.deleteData(
        key: StorageService.I.loginDataStoreKey,
      ),
      StorageService.I.deleteData(
        key: StorageService.I.authTokenStoreKey,
      ),
      StorageService.I.deleteData(
        key: StorageService.I.loginExpireTime,
      ),
    ]);
    BlocProvider.of<UserBloc>(event.context).add(UpdateUserDataEvent(
      context: event.context,
      user: null,
    ));
    BlocProvider.of<AppServiceBloc>(event.context).api.api.myToken = null;
    emit(state
        .copyWith(logoutStatus: ApiStatus.processing, wishlistProductId: []));
    final resData = await _logout();
    emit(state.copyWith(
      logoutStatus: ApiStatus.completed,
    ));

    if (resData != null) {
      showSnackBar(
        message: "",
        title: "Logout Success!",
        context: rootNavigatorKey.currentState!.context,
        backgroundColor: Colors.green,
        titleColor: Colors.white,
      );
    }
  }

  Future<Map<String, dynamic>?> _logout() async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: ApiKey.logout,
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

  void _updateProfileImagepath(
      UpdateProfileImagePathEvent event, Emitter emit) {
    emit(state.copyWith(profileImagePath: event.data));
  }

  void _updateUser(UpdateUserDataEvent event, Emitter emit) {
    if (event.user == null) {
      emit(state.clearUserData().copyWith(isLogin: false));
    } else {
      emit(state.copyWith(user: event.user, isLogin: true));
    }
  }
}
