part of 'wishlist_bloc.dart';

class WishlistState extends Equatable {
  WishlistState({this.nextPageUrl, this.imagePath = ""});

  String? nextPageUrl;
  final String imagePath;

  WishlistState clearNextPageUrl() {
    nextPageUrl = null;
    return copyWith();
  }

  WishlistState copyWith({String? nextPageUrl, String? imagePath}) {
    return WishlistState(
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  List<Object> get props => [];
}
