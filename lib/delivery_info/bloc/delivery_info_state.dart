part of 'delivery_info_bloc.dart';

class DeliveryInfoState extends Equatable {
  DeliveryInfoState({
    this.stateGetState = ApiStatus.processing,
    this.townshipGetState = ApiStatus.completed,
    this.states = const [],
    this.townships = const [],
    this.selectedTownship,
    this.selectedState,
    this.isSelectedTownship = false,
    this.sendStatus = ApiStatus.completed,
  });

  final ApiStatus stateGetState;
  final ApiStatus townshipGetState;
  final List<StateModel> states;
  StateModel? selectedState;
  final List<TownshipModel> townships;
  TownshipModel? selectedTownship;
  final bool isSelectedTownship;
  final ApiStatus sendStatus;

  DeliveryInfoState clearState() {
    selectedState = null;
    return copyWith();
  }

  DeliveryInfoState clearTownship() {
    selectedTownship = null;
    return copyWith();
  }

  @override
  List<Object?> get props => [
        stateGetState,
        townshipGetState,
        states,
        townships,
        selectedState,
        selectedTownship,
        isSelectedTownship,
        sendStatus,
      ];
  DeliveryInfoState copyWith({
    ApiStatus? stateGetState,
    ApiStatus? townshipGetState,
    List<StateModel>? states,
    List<TownshipModel>? townships,
    StateModel? selectedState,
    TownshipModel? selectedTownship,
    bool? isSelectedTownship,
    ApiStatus? sendStatus,
  }) {
    return DeliveryInfoState(
      stateGetState: stateGetState ?? this.stateGetState,
      townshipGetState: townshipGetState ?? this.townshipGetState,
      states: states ?? this.states,
      townships: townships ?? this.townships,
      selectedState: selectedState ?? this.selectedState,
      selectedTownship: selectedTownship ?? this.selectedTownship,
      isSelectedTownship: isSelectedTownship ?? this.isSelectedTownship,
      sendStatus: sendStatus ?? this.sendStatus,
    );
  }
}
