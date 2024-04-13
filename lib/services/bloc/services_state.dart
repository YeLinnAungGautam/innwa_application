part of 'services_bloc.dart';

class ServicesState extends Equatable {
  ServicesState({
    this.serviceApiStatus = ApiStatus.processing,
    this.services = const [],
    this.selectedService,
    this.selectedDate,
    this.isSelectedDate = false,
    this.time,
    this.isSelectedTime = false,
    this.sendStatus = ApiStatus.completed,
  });

  final ApiStatus serviceApiStatus;
  final List<ServiceModel> services;
  ServiceModel? selectedService;
  DateTime? selectedDate;
  final bool isSelectedDate;
  TimeOfDay? time;
  final bool isSelectedTime;
  final ApiStatus sendStatus;

  ServicesState clearDateTime() {
    selectedDate = null;
    selectedService = null;
    time == null;
    return copyWith();
  }

  @override
  List<Object?> get props => [
        serviceApiStatus,
        services,
        selectedService,
        selectedDate,
        time,
        isSelectedTime,
        sendStatus,
      ];

  ServicesState copyWith({
    ApiStatus? serviceApiStatus,
    List<ServiceModel>? services,
    ServiceModel? selectedService,
    DateTime? selectedDate,
    TimeOfDay? time,
    bool? isSelectedDate,
    bool? isSelectedTime,
    ApiStatus? sendStatus,
  }) {
    return ServicesState(
      serviceApiStatus: serviceApiStatus ?? this.serviceApiStatus,
      services: services ?? this.services,
      selectedService: selectedService ?? this.selectedService,
      selectedDate: selectedDate ?? this.selectedDate,
      time: time ?? this.time,
      isSelectedDate: isSelectedDate ?? this.isSelectedDate,
      isSelectedTime: isSelectedTime ?? this.isSelectedTime,
      sendStatus: sendStatus ?? this.sendStatus,
    );
  }
}
