part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent({required this.context});
  final BuildContext context;
  @override
  List<Object> get props => [];
}

final class ClickRegisteBtnEvent extends RegisterEvent {
  const ClickRegisteBtnEvent({required super.context});
}

final class UpdateNameEvent extends RegisterEvent {
  const UpdateNameEvent({required super.context, this.data});
  final String? data;
}

final class UpdateEmailEvent extends RegisterEvent {
  const UpdateEmailEvent({required super.context, this.data});
  final String? data;
}

final class UpdatePasswordEvent extends RegisterEvent {
  const UpdatePasswordEvent({required super.context, this.data});
  final String? data;
}

final class UpdateConfirmPasswordEvent extends RegisterEvent {
  const UpdateConfirmPasswordEvent({required super.context, this.data});
  final String? data;
}
