part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.name = "",
    this.email = "",
    this.password = "",
    this.confirmPassword = "",
    this.errors = const {},
    this.sendStatus = ApiStatus.completed,
  });

  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final Map<String, dynamic> errors;
  final ApiStatus sendStatus;

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        confirmPassword,
        errors,
        sendStatus,
      ];

  RegisterState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    Map<String, dynamic>? errors,
    ApiStatus? sendStatus,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      errors: errors ?? this.errors,
      sendStatus: sendStatus ?? this.sendStatus,
    );
  }
}
