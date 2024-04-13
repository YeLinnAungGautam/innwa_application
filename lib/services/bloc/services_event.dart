part of 'services_bloc.dart';

sealed class ServicesEvent extends Equatable {
  const ServicesEvent({required this.context});
  final BuildContext context;
  @override
  List<Object> get props => [];
}

final class GetServiceEvent extends ServicesEvent {
  const GetServiceEvent({required super.context});
}

final class UpdateServiceEvent extends ServicesEvent {
  const UpdateServiceEvent({required super.context, required this.service});
  final ServiceModel service;
}

final class ShowTimePickerEvent extends ServicesEvent {
  const ShowTimePickerEvent({required super.context});
}

final class ShowDatePickerEvent extends ServicesEvent {
  const ShowDatePickerEvent({required super.context});
}

final class ClickBookAppointmentEvent extends ServicesEvent {
  const ClickBookAppointmentEvent({required super.context});
}
