part of 'profile_edit_bloc.dart';

class ProfileEditState extends Equatable {
  ProfileEditState({
    this.selectedFile,
    this.isSelectedFile = false,
    this.stateGetState = ApiStatus.processing,
    this.townshipGetState = ApiStatus.completed,
    this.states = const [],
    this.townships = const [],
    this.selectedTownship,
    this.selectedState,
    this.isSelectedState = false,
    this.isSelectedTownship = false,
    this.sendStatus = ApiStatus.completed,
  });

  File? selectedFile;
  final bool isSelectedFile;
  final ApiStatus stateGetState;
  final ApiStatus townshipGetState;
  final List<StateModel> states;
  StateModel? selectedState;
  final bool isSelectedState;
  final List<TownshipModel> townships;
  TownshipModel? selectedTownship;
  final bool isSelectedTownship;
  final ApiStatus sendStatus;

  ProfileEditState clearImage() {
    selectedFile = null;
    return copyWith();
  }

  ProfileEditState clearState() {
    selectedState = null;
    return copyWith();
  }

  ProfileEditState clearTownship() {
    selectedTownship = null;
    return copyWith();
  }

  @override
  List<Object?> get props => [
        selectedFile,
        isSelectedFile,
        stateGetState,
        townshipGetState,
        states,
        townships,
        selectedState,
        selectedTownship,
        isSelectedState,
        isSelectedTownship,
        sendStatus,
      ];
  ProfileEditState copyWith({
    File? selectedFile,
    bool? isSelectedFile,
    ApiStatus? stateGetState,
    ApiStatus? townshipGetState,
    List<StateModel>? states,
    List<TownshipModel>? townships,
    StateModel? selectedState,
    TownshipModel? selectedTownship,
    bool? isSelectedState,
    bool? isSelectedTownship,
    ApiStatus? sendStatus,
  }) {
    return ProfileEditState(
      selectedFile: selectedFile ?? this.selectedFile,
      isSelectedFile: isSelectedFile ?? this.isSelectedFile,
      stateGetState: stateGetState ?? this.stateGetState,
      townshipGetState: townshipGetState ?? this.townshipGetState,
      states: states ?? this.states,
      townships: townships ?? this.townships,
      selectedState: selectedState ?? this.selectedState,
      selectedTownship: selectedTownship ?? this.selectedTownship,
      isSelectedState: isSelectedState ?? this.isSelectedState,
      isSelectedTownship: isSelectedTownship ?? this.isSelectedTownship,
      sendStatus: sendStatus ?? this.sendStatus,
    );
  }
}
