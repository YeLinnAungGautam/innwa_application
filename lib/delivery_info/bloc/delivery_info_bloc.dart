import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_path.dart';
import 'package:innwa_mobile_dev/_application/router_service/router.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/cart/bloc/cart_bloc.dart';
import 'package:innwa_mobile_dev/profile/profile_edit/model/state_model.dart';
import 'package:innwa_mobile_dev/profile/profile_edit/model/township_model.dart';
import 'package:innwa_mobile_dev/util/ui/snack_bar.dart';

part 'delivery_info_event.dart';
part 'delivery_info_state.dart';

class DeliveryInfoBloc extends Bloc<DeliveryInfoEvent, DeliveryInfoState> {
  DeliveryInfoBloc(this._restAPI) : super(DeliveryInfoState()) {
    on<GetStateEvent>(_getStateEvent);
    on<UpdateSelectedStateEvent>(_updateSelectedState);
    on<GetTownshipEvent>(_getTownshipEvent);
    on<UpdateSelectedTownshipEvent>(_updateSelectedTownship);
    on<ClickNextBtnEvent>(_clickNextBtn);
  }

  final RestAPI _restAPI;

  void _clickNextBtn(ClickNextBtnEvent event, Emitter emit) {
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(event.context);

    final validate = BlocProvider.of<CartBloc>(event.context)
        .formKey
        .currentState!
        .validate();
    if (validate &&
        cartBloc.state.selectedState != null &&
        cartBloc.state.selectedTownship != null) {
      RouterService.of(event.context)
          .push(RouterPath.I.orderInfoScreen.fullPath);
    } else if (cartBloc.state.selectedState == null ||
        cartBloc.state.selectedTownship == null) {
      showSnackBar(
        message: "Please select state & township",
        title: "State & Township",
        context: event.context,
        backgroundColor: Colors.amber,
        titleColor: Colors.black,
        messageColor: Colors.black,
      );
    }
  }

  void _updateSelectedTownship(
    UpdateSelectedTownshipEvent event,
    Emitter emit,
  ) async {
    if (event.data.id != state.selectedTownship?.id) {
      BlocProvider.of<CartBloc>(event.context).add(
          UpdateCartTownshipEvent(context: event.context, data: event.data));
      emit(state.copyWith(
          selectedTownship: event.data, isSelectedTownship: true));
    }
  }

  Future<void> _getTownshipEvent(GetTownshipEvent event, Emitter emit) async {
    emit(state.copyWith(townshipGetState: ApiStatus.processing));
    final resData = await _getTownship(stateId: state.selectedState!.id);
    if (resData != null) {
      final jsonList = resData["townships"] as List;
      final List<TownshipModel> data =
          jsonList.map((e) => TownshipModel.fromJson(e)).toList();

      emit(state.copyWith(
          townshipGetState: ApiStatus.completed, townships: data));
    } else {
      emit(state.copyWith(townshipGetState: ApiStatus.failure));
    }
  }

  void _updateSelectedState(UpdateSelectedStateEvent event, Emitter emit) {
    if (event.data.id != state.selectedState?.id) {
      emit(
        state.copyWith(
          townships: [],
        ),
      );
      BlocProvider.of<CartBloc>(event.context)
        ..add(UpdateCartStateEvent(context: event.context, data: event.data))
        ..add(ClearCartTownshipEvent(context: event.context));
      emit(state.clearTownship().copyWith(
            selectedState: event.data,
          ));
      add(GetTownshipEvent(context: event.context));
    }
  }

  Future<void> _getStateEvent(GetStateEvent event, Emitter emit) async {
    emit(state.copyWith(stateGetState: ApiStatus.processing));
    final resData = await _getStates();
    if (resData != null) {
      final jsonList = resData["states"] as List;
      final List<StateModel> data =
          jsonList.map((e) => StateModel.fromJson(e)).toList();
      emit(state.copyWith(stateGetState: ApiStatus.completed, states: data));
    } else {
      emit(state.copyWith(stateGetState: ApiStatus.failure));
    }
  }

  Future<Map<String, dynamic>?> _getStates() async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: ApiKey.states,
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

  Future<Map<String, dynamic>?> _getTownship({required int stateId}) async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: "${ApiKey.township}/$stateId",
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
