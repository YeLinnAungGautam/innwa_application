import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/profile/profile_edit/model/state_model.dart';
import 'package:innwa_mobile_dev/profile/profile_edit/model/township_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._restAPI) : super(CartState()) {
    on<UpdateCartStateEvent>(_updateCartStateEvent);
    on<UpdateCartTownshipEvent>(_updateCartTownshipEvent);
    on<ClearCartTownshipEvent>(_clearCartTownship);
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController additionController = TextEditingController();

  void _clearCartTownship(ClearCartTownshipEvent event, Emitter emit) {
    emit(state.clearTownship().copyWith(stateChange: !state.stateChange));
  }

  void _updateCartTownshipEvent(UpdateCartTownshipEvent event, Emitter emit) {
    emit(state.copyWith(selectedTownship: event.data));
  }

  void _updateCartStateEvent(UpdateCartStateEvent event, Emitter emit) {
    debugPrint(
        "-----------Update SelectedState---------------------${event.data}--------------------------------");
    emit(state.copyWith(selectedState: event.data));
  }

  final RestAPI _restAPI;
}
