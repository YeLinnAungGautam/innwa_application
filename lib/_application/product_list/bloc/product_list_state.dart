part of 'product_list_bloc.dart';

class ProductListState extends Equatable {
  ProductListState({
    this.imagePath = "",
    this.disImagePath = "",
    this.nextPageUrl,
    this.shopStatus = ApiStatus.processing,
    this.filterData,
    this.selectedTitle,
    this.selectedCategoryTab,
    this.selectedBrandsTab,
    this.selectedSpecificationsTab,
    this.filterSelectedCategory = const [],
    this.filterUsedCategory = const [],
    this.filterSelectedBrand = const [],
    this.filterUsedBrand = const [],
    this.filterSelectedSpec = const [],
    this.filterUsedSpec = const [],
  });

  final String imagePath;
  final String disImagePath;
  final ApiStatus shopStatus;
  final FilterModel? filterData;
  final int? selectedTitle;
  final int? selectedCategoryTab;
  final int? selectedBrandsTab;
  final int? selectedSpecificationsTab;
  final List<int> filterSelectedCategory;
  final List<int> filterUsedCategory;
  final List<int> filterSelectedBrand;
  final List<int> filterUsedBrand;
  final List<int> filterSelectedSpec;
  final List<int> filterUsedSpec;
  String? nextPageUrl;

  ProductListState clearNextPageUrl() {
    nextPageUrl = null;
    return copyWith();
  }

  @override
  List<Object?> get props => [
        imagePath,
        disImagePath,
        nextPageUrl,
        shopStatus,
        filterData,
        selectedTitle,
        selectedCategoryTab,
        selectedBrandsTab,
        selectedSpecificationsTab,
        filterSelectedCategory,
        filterUsedCategory,
        filterSelectedBrand,
        filterUsedBrand,
        filterSelectedSpec,
        filterUsedSpec,
      ];
  ProductListState copyWith({
    String? imagePath,
    String? disImagePath,
    String? nextPageUrl,
    ApiStatus? shopStatus,
    FilterModel? filterData,
    int? selectedTitle,
    int? selectedCategoryTab,
    int? selectedBrandsTab,
    int? selectedSpecificationsTab,
    List<int>? filterSelectedCategory,
    List<int>? filterUsedCategory,
    List<int>? filterSelectedBrand,
    List<int>? filterUsedBrand,
    List<int>? filterSelectedSpec,
    List<int>? filterUsedSpec,
  }) {
    return ProductListState(
      imagePath: imagePath ?? this.imagePath,
      disImagePath: disImagePath ?? this.disImagePath,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      shopStatus: shopStatus ?? this.shopStatus,
      filterData: filterData ?? this.filterData,
      selectedTitle: selectedTitle ?? this.selectedTitle,
      selectedCategoryTab: selectedCategoryTab ?? this.selectedCategoryTab,
      selectedBrandsTab: selectedBrandsTab ?? this.selectedBrandsTab,
      selectedSpecificationsTab:
          selectedSpecificationsTab ?? this.selectedSpecificationsTab,
      filterSelectedCategory:
          filterSelectedCategory ?? this.filterSelectedCategory,
      filterUsedCategory: filterUsedCategory ?? this.filterUsedCategory,
      filterSelectedBrand: filterSelectedBrand ?? this.filterSelectedBrand,
      filterUsedBrand: filterUsedBrand ?? this.filterUsedBrand,
      filterSelectedSpec: filterSelectedSpec ?? this.filterSelectedSpec,
      filterUsedSpec: filterUsedSpec ?? this.filterUsedSpec,
    );
  }
}
