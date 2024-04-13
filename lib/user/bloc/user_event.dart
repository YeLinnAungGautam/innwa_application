part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent({required this.context});
  final BuildContext context;

  @override
  List<Object> get props => [];
}

final class UpdateUserDataEvent extends UserEvent {
  const UpdateUserDataEvent({required super.context, this.user});
  final UserModel? user;
}

final class UpdateProfileImagePathEvent extends UserEvent {
  const UpdateProfileImagePathEvent(
      {required super.context, required this.data});
  final String data;
}

final class LogoutEvent extends UserEvent {
  const LogoutEvent({required super.context});
}
