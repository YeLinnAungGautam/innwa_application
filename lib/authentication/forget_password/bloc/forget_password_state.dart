part of 'forget_password_bloc.dart';

class ForgetPasswordState extends Equatable {
  const ForgetPasswordState({this.sendStatus = ApiStatus.completed});

  final ApiStatus sendStatus;

  @override
  List<Object> get props => [sendStatus];

  ForgetPasswordState copyWith({ApiStatus? sendStatus}) {
    return ForgetPasswordState(
      sendStatus: sendStatus ?? this.sendStatus,
    );
  }
}
