part of 'cart_bloc.dart';

class CartState extends Equatable {
  CartState(
      {this.selectedState, this.selectedTownship, this.stateChange = false});
  StateModel? selectedState;
  TownshipModel? selectedTownship;
  final bool stateChange;

  @override
  List<Object?> get props => [selectedState, selectedTownship, stateChange];

  CartState clearState() {
    selectedState = null;
    return copyWith();
  }

  CartState clearTownship() {
    selectedTownship = null;
    return copyWith();
  }

  CartState copyWith({
    StateModel? selectedState,
    TownshipModel? selectedTownship,
    bool? stateChange,
  }) {
    return CartState(
      selectedState: selectedState ?? this.selectedState,
      selectedTownship: selectedTownship ?? this.selectedTownship,
      stateChange: stateChange ?? this.stateChange,
    );
  }
}
