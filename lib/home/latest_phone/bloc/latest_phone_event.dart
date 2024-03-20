part of 'latest_phone_bloc.dart';

sealed class LatestPhoneEvent extends Equatable {
  const LatestPhoneEvent({required this.context});
  final BuildContext context;
  @override
  List<Object> get props => [];
}

final class GetLatestPhoneEvent extends LatestPhoneEvent {
  const GetLatestPhoneEvent({required super.context});
}

final class GetLatestComputerEvent extends LatestPhoneEvent {
  const GetLatestComputerEvent({required super.context});
}

final class GetLatestLaptopEvent extends LatestPhoneEvent {
  const GetLatestLaptopEvent({required super.context});
}
