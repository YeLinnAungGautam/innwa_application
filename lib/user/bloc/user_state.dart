part of 'user_bloc.dart';

class UserState extends Equatable {
  UserState({
    this.isLogin = false,
    this.user,
    this.profileImagePath = "",
    this.logoutStatus = ApiStatus.completed,
  });
  final bool isLogin;
  final String profileImagePath;
  final ApiStatus logoutStatus;
  UserModel? user;

  @override
  List<Object?> get props => [isLogin, user, profileImagePath, logoutStatus];

  UserState clearUserData() {
    user = null;
    return copyWith();
  }

  UserState copyWith({
    bool? isLogin,
    UserModel? user,
    String? profileImagePath,
    ApiStatus? logoutStatus,
  }) {
    return UserState(
      isLogin: isLogin ?? this.isLogin,
      user: user ?? this.user,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      logoutStatus: logoutStatus ?? this.logoutStatus,
    );
  }
}
