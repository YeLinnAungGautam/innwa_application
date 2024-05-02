part of 'user_bloc.dart';

class UserState extends Equatable {
  UserState({
    this.isLogin = false,
    this.user,
    this.profileImagePath = "",
    this.logoutStatus = ApiStatus.completed,
    this.wishlistProductId = const [],
  });
  final bool isLogin;
  final String profileImagePath;
  final ApiStatus logoutStatus;
  final List<int> wishlistProductId;
  UserModel? user;

  @override
  List<Object?> get props =>
      [isLogin, user, profileImagePath, logoutStatus, wishlistProductId];

  UserState clearUserData() {
    user = null;
    return copyWith();
  }

  UserState copyWith({
    bool? isLogin,
    UserModel? user,
    String? profileImagePath,
    ApiStatus? logoutStatus,
    List<int>? wishlistProductId,
  }) {
    return UserState(
      isLogin: isLogin ?? this.isLogin,
      user: user ?? this.user,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      wishlistProductId: wishlistProductId ?? this.wishlistProductId,
    );
  }
}
