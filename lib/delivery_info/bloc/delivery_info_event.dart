part of 'delivery_info_bloc.dart';

sealed class DeliveryInfoEvent extends Equatable {
  const DeliveryInfoEvent({required this.context});
  final BuildContext context;
  @override
  List<Object> get props => [];
}

final class GetStateEvent extends DeliveryInfoEvent {
  const GetStateEvent({required super.context});
}

final class UpdateSelectedStateEvent extends DeliveryInfoEvent {
  const UpdateSelectedStateEvent({required super.context, required this.data});
  final StateModel data;
}

final class UpdateSelectedTownshipEvent extends DeliveryInfoEvent {
  const UpdateSelectedTownshipEvent({
    required super.context,
    required this.data,
  });
  final TownshipModel data;
}

final class GetTownshipEvent extends DeliveryInfoEvent {
  const GetTownshipEvent({required super.context});
}

final class ClickNextBtnEvent extends DeliveryInfoEvent {
  const ClickNextBtnEvent({required super.context});
}
