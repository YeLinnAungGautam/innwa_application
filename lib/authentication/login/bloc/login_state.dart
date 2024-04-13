part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = "",
    this.password = "",
    this.errors = const {},
    this.sendStatus = ApiStatus.completed,
  });

  final String email;
  final String password;
  final Map<String, dynamic> errors;
  final ApiStatus sendStatus;
  @override
  List<Object> get props => [
        email,
        password,
        errors,
        sendStatus,
      ];

  LoginState copyWith({
    String? email,
    String? password,
    Map<String, dynamic>? errors,
    ApiStatus? sendStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      errors: errors ?? this.errors,
      sendStatus: sendStatus ?? this.sendStatus,
    );
  }
}
