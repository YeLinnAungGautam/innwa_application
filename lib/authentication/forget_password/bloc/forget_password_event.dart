part of 'forget_password_bloc.dart';

sealed class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent({required this.context});
  final BuildContext context;
  @override
  List<Object> get props => [];
}

final class SubmitForgetPasswordEvent extends ForgetPasswordEvent {
  const SubmitForgetPasswordEvent({required super.context});
}
