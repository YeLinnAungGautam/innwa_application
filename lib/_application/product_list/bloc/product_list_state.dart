part of 'product_list_bloc.dart';

class ProductListState extends Equatable {
  ProductListState({
    this.imagePath = "",
    this.disImagePath = "",
    this.nextPageUrl,
    this.shopStatus = ApiStatus.processing,
    this.filterData,
  });

  final String imagePath;
  final String disImagePath;
  final ApiStatus shopStatus;
  final FilterModel? filterData;
  String? nextPageUrl;

  ProductListState clearNextPageUrl() {
    nextPageUrl = null;
    return copyWith();
  }

  @override
  List<Object?> get props =>
      [imagePath, disImagePath, nextPageUrl, shopStatus, filterData];
  ProductListState copyWith({
    String? imagePath,
    String? disImagePath,
    String? nextPageUrl,
    ApiStatus? shopStatus,
    FilterModel? filterData,
  }) {
    return ProductListState(
      imagePath: imagePath ?? this.imagePath,
      disImagePath: disImagePath ?? this.disImagePath,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      shopStatus: shopStatus ?? this.shopStatus,
      filterData: filterData ?? this.filterData,
    );
  }
}
