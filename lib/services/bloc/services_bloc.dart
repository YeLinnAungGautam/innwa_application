import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/services/model/service_model.dart';
import 'package:innwa_mobile_dev/user/bloc/user_bloc.dart';
import 'package:innwa_mobile_dev/util/ui/snack_bar.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc(this._restAPI) : super(ServicesState()) {
    on<GetServiceEvent>(_getServiceEvent);
    on<UpdateServiceEvent>(_updateService);
    on<ShowDatePickerEvent>(_showDatePicker);
    on<ShowTimePickerEvent>(_showTimePicker);
    on<ClickBookAppointmentEvent>(_clickBookAppointment);
  }

  final RestAPI _restAPI;
  final GlobalKey<FormState> form = GlobalKey();
  final TextEditingController nameController = TextEditingController();

  Future<void> _clickBookAppointment(
      ClickBookAppointmentEvent event, Emitter emit) async {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(event.context);
    final validate = form.currentState!.validate();
    if (validate) {
      emit(state.copyWith(sendStatus: ApiStatus.processing));
      final resData = await _bookAppointment(data: {
        "name": nameController.text,
        "email": userBloc.state.user!.email,
        "service_id": state.selectedService!.id,
        "date": state.selectedDate.toString().split(" ")[0],
        "time": '${state.time!.hour} : ${state.time!.minute}',
      });
      emit(state.copyWith(sendStatus: ApiStatus.processing));

      if (resData != null) {
        nameController.text = "";
        emit(state
            .clearDateTime()
            .copyWith(isSelectedDate: false, isSelectedTime: false));
        showSnackBar(
          message: resData["message"],
          title: "Book Appointment",
          context: event.context,
          backgroundColor: Colors.green,
          titleColor: Colors.white,
          messageColor: Colors.white,
        );
      } else {
        showSnackBar(
          message: "Book Appointment Fail!",
          title: "Book Appoinment",
          context: event.context,
          backgroundColor: Colors.red,
          titleColor: Colors.white,
          messageColor: Colors.white,
        );
      }
      debugPrint(
          "-----------Go Server-----------------------------------------------------");
    }
  }

  Future<Map<String, dynamic>?> _bookAppointment(
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
      path: ApiKey.bookAppointment,
      data: data,
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

  Future<void> _showTimePicker(ShowTimePickerEvent event, Emitter emit) async {
    final time = await showTimePicker(
      context: event.context,
      initialTime: state.time ??
          TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
    );
    if (time != null) {
      emit(state.copyWith(time: time, isSelectedTime: true));
    }
  }

  void _updateService(UpdateServiceEvent event, Emitter emit) {
    emit(state.copyWith(selectedService: event.service));
  }

  Future<void> _showDatePicker(ShowDatePickerEvent event, Emitter emit) async {
    final date = await showDatePicker(
      context: event.context,
      firstDate: state.selectedDate ?? DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (date != null) {
      emit(state.copyWith(selectedDate: date, isSelectedDate: true));
    }
  }

  Future<void> _getServiceEvent(GetServiceEvent event, Emitter emit) async {
    emit(state.copyWith(serviceApiStatus: ApiStatus.processing));
    final resData = await _getServices();
    if (resData != null) {
      final jsonList = resData["services"] as List;
      final List<ServiceModel> data =
          jsonList.map((e) => ServiceModel.fromJson(e)).toList();
      emit(state.copyWith(
        serviceApiStatus: ApiStatus.completed,
        services: data,
      ));
    } else {
      emit(state.copyWith(serviceApiStatus: ApiStatus.failure));
    }
  }

  Future<Map<String, dynamic>?> _getServices() async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: ApiKey.getServices,
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
