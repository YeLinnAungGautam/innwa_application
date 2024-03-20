part of 'home_banner_bloc.dart';

class HomeBannerState extends Equatable {
  const HomeBannerState({
    this.imagePath,
    this.sliders = const [],
    this.subBannerImagePath,
    this.subBanners = const [],
    this.brandPath,
    this.brands = const [],
  });

  final String? imagePath;
  final List<SliderModel> sliders;
  final String? subBannerImagePath;
  final List<SubBannerModel> subBanners;
  final String? brandPath;
  final List<BrandModel> brands;

  @override
  List<Object?> get props => [
        imagePath,
        sliders,
        subBannerImagePath,
        subBanners,
        brands,
        brandPath,
      ];

  HomeBannerState copyWith({
    String? imagePath,
    List<SliderModel>? sliders,
    String? subBannerImagePath,
    List<SubBannerModel>? subBanners,
    List<BrandModel>? brands,
    String? brandPath,
  }) {
    return HomeBannerState(
        imagePath: imagePath ?? this.imagePath,
        sliders: sliders ?? this.sliders,
        subBannerImagePath: subBannerImagePath ?? this.subBannerImagePath,
        subBanners: subBanners ?? this.subBanners,
        brands: brands ?? this.brands,
        brandPath: brandPath ?? this.brandPath);
  }
}
