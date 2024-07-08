part of 'wishlist_bloc.dart';

class WishlistState extends Equatable {
   WishlistState({
    this.nextPageUrl,
    this.imagePath = "",
    this.wishListData ,
    this.message = 'null',
    this.apiStatus = ApiStatus.processing,
    this.favoritesSlug,
  });

   String? nextPageUrl;
   String imagePath;
   List<SearchProductModel>? wishListData;
   final String message;
   ApiStatus apiStatus;
   List<String>? favoritesSlug;

  WishlistState clearNextPageUrl() {
    nextPageUrl = null ;
    return copyWith();
  }

  WishlistState copyWith({
    String? nextPageUrl,
    String? imagePath,
    List<SearchProductModel>? wishListData,
    String? message,
    ApiStatus? apiStatus,
    List<String>? favoritesSlug,
  }) {
    return WishlistState(
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      imagePath: imagePath ?? this.imagePath,
      wishListData: wishListData ?? this.wishListData,
      message: message ?? this.message,
      apiStatus: apiStatus ?? this.apiStatus,
      favoritesSlug: favoritesSlug ?? this.favoritesSlug,
    );
  }

  @override
  List<Object> get props => [
        imagePath,
        wishListData??[] ,
        nextPageUrl??"",
        message,
        apiStatus,
        favoritesSlug??[],
      ];
}
