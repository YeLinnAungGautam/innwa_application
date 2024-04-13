part of 'profile_edit_bloc.dart';

sealed class ProfileEditEvent extends Equatable {
  const ProfileEditEvent({required this.context});
  final BuildContext context;

  @override
  List<Object> get props => [];
}

final class ProfileInitialEvent extends ProfileEditEvent {
  const ProfileInitialEvent({required super.context});
}

final class GetImageFromGalleryEvent extends ProfileEditEvent {
  const GetImageFromGalleryEvent({required super.context});
}

final class GetImageFromCameraEvent extends ProfileEditEvent {
  const GetImageFromCameraEvent({required super.context});
}

final class ClearImageEvent extends ProfileEditEvent {
  const ClearImageEvent({required super.context});
}

final class UpdateFormEvent extends ProfileEditEvent {
  const UpdateFormEvent({required super.context});
}

final class GetStateEvent extends ProfileEditEvent {
  const GetStateEvent({required super.context});
}

final class UpdateSelectedStateEvent extends ProfileEditEvent {
  const UpdateSelectedStateEvent(
      {required super.context, required this.data, this.canPop = true});
  final StateModel data;
  final bool canPop;
}

final class GetTownshipEvent extends ProfileEditEvent {
  const GetTownshipEvent({required super.context});
}

final class ShowStateBotttomSheetEvent extends ProfileEditEvent {
  const ShowStateBotttomSheetEvent({required super.context});
}

final class ShowTownshipBottomsheetEvent extends ProfileEditEvent {
  const ShowTownshipBottomsheetEvent({required super.context});
}

final class UpdateSelectedTownshipEvent extends ProfileEditEvent {
  const UpdateSelectedTownshipEvent(
      {required super.context, required this.data, this.canPop = true});
  final TownshipModel data;
  final bool canPop;
}
