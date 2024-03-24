part of 'product_search_bloc.dart';

class ProductSearchState extends Equatable {
  ProductSearchState(
      {this.hasFocus = false,
      this.searchText = "",
      this.nextPageUrl,
      this.imagePath = "",
      this.disImagePath = ""});
  final bool hasFocus;
  final String searchText;
  final String imagePath;
  final String disImagePath;
  String? nextPageUrl;

  ProductSearchState clearNextPageUrl() {
    nextPageUrl = null;
    return copyWith();
  }

  @override
  List<Object?> get props =>
      [hasFocus, searchText, nextPageUrl, imagePath, disImagePath];
  ProductSearchState copyWith({
    bool? hasFocus,
    String? searchText,
    String? nextPageUrl,
    String? imagePath,
    String? disImagePath,
  }) {
    return ProductSearchState(
      hasFocus: hasFocus ?? this.hasFocus,
      searchText: searchText ?? this.searchText,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      imagePath: imagePath ?? this.imagePath,
      disImagePath: disImagePath ?? this.disImagePath,
    );
  }
}
