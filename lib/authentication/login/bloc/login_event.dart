part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent({required this.context});
  final BuildContext context;
  @override
  List<Object> get props => [];
}

final class ClickLoginBtnEvent extends LoginEvent {
  const ClickLoginBtnEvent({required super.context});
}

final class UpdateLoginEmailEvent extends LoginEvent {
  const UpdateLoginEmailEvent({required super.context, this.data});
  final String? data;
}

final class UpdateLoginPasswordEvent extends LoginEvent {
  const UpdateLoginPasswordEvent({required super.context, this.data});
  final String? data;
}

final class GoogleLoginEvent extends LoginEvent {
  const GoogleLoginEvent({required super.context});
}
