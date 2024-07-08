import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'promotion_detail_response.g.dart';

@JsonSerializable()
class PromotionDetailResponse extends Equatable {
  const PromotionDetailResponse({
    required this.status,
    required this.promotionBannerImagePath,
    required this.disImagePath,
    required this.productFeatureImagePath,
    required this.promotion,
    required this.products,
  });

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'promotion_banner_image_path')
  final String? promotionBannerImagePath;

  @JsonKey(name: 'dis_image_path')
  final String? disImagePath;

  @JsonKey(name: 'product_feature_image_path')
  final String? productFeatureImagePath;

  @JsonKey(name: "promotion")
  final PromotionDetail? promotion;

  @JsonKey(name: 'products')
  final Products? products;

  factory PromotionDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PromotionDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionDetailResponseToJson(this);

  @override
  List<Object?> get props => [
        status,
        promotionBannerImagePath,
        disImagePath,
        productFeatureImagePath,
        promotion,
        products,
      ];
}

@JsonSerializable()
class PromotionDetail extends Equatable {
  const PromotionDetail({
    required this.id,
    required this.nameEn,
    required this.nameMm,
    required this.slug,
    required this.featuredImage,
    required this.bannerImage,
    required this.descriptionEn,
    required this.descriptionMm,
  });

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name_en')
  final String? nameEn;

  @JsonKey(name: 'name_mm')
  final String? nameMm;

  @JsonKey(name: "slug")
  final String? slug;

  @JsonKey(name: 'featured_image')
  final String? featuredImage;

  @JsonKey(name: 'banner_image')
  final dynamic bannerImage;

  @JsonKey(name: 'description_en')
  final String? descriptionEn;

  @JsonKey(name: 'description_mm')
  final String? descriptionMm;

  factory PromotionDetail.fromJson(Map<String, dynamic> json) =>
      _$PromotionDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionDetailToJson(this);

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameMm,
        slug,
        featuredImage,
        bannerImage,
        descriptionEn,
        descriptionMm,
      ];
}

@JsonSerializable()
class Products extends Equatable {
  const Products({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  @JsonKey(name: 'current_page')
  final int? currentPage;

  @JsonKey(name: "data")
  final List<PromotionProductData>? data;

  @JsonKey(name: 'first_page_url')
  final String? firstPageUrl;

  @JsonKey(name: "from")
  final int? from;

  @JsonKey(name: 'last_page')
  final int? lastPage;

  @JsonKey(name: 'last_page_url')
  final String? lastPageUrl;

  final List<Link>? links;

  @JsonKey(name: 'next_page_url')
  final String? nextPageUrl;

  final String? path;

  @JsonKey(name: 'per_page')
  final int? perPage;

  @JsonKey(name: 'prev_page_url')
  final dynamic prevPageUrl;

  @JsonKey(name: "to")
  final int? to;

  @JsonKey(name: "total")
  final int? total;

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsToJson(this);

  @override
  List<Object?> get props => [
        currentPage,
        data,
        firstPageUrl,
        from,
        lastPage,
        lastPageUrl,
        links,
        nextPageUrl,
        path,
        perPage,
        prevPageUrl,
        to,
        total,
      ];
}

@JsonSerializable()
class PromotionProductData extends Equatable {
  const PromotionProductData({
    required this.productPriceId,
    required this.productId,
    required this.disStartDate,
    required this.disEndDate,
    required this.disPrice,
    required this.cashback,
    required this.gift,
    required this.disImage,
    required this.deletedAt,
    required this.priceMmk,
    required this.product,
  });

  @JsonKey(name: 'product_price_id')
  final int? productPriceId;

  @JsonKey(name: 'product_id')
  final int? productId;

  @JsonKey(name: 'dis_start_date')
  final DateTime? disStartDate;

  @JsonKey(name: 'dis_end_date')
  final DateTime? disEndDate;

  @JsonKey(name: 'dis_price')
  final String? disPrice;

  @JsonKey(name: "cashback")
  final String? cashback;

  @JsonKey(name: "gift")
  final String? gift;

  @JsonKey(name: 'dis_image')
  final dynamic disImage;

  @JsonKey(name: 'deleted_at')
  final dynamic deletedAt;

  @JsonKey(name: 'price_mmk')
  final int? priceMmk;

  @JsonKey(name: "product")
  final Product? product;

  factory PromotionProductData.fromJson(Map<String, dynamic> json) =>
      _$PromotionProductDataFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionProductDataToJson(this);

  @override
  List<Object?> get props => [
        productPriceId,
        productId,
        disStartDate,
        disEndDate,
        disPrice,
        cashback,
        gift,
        disImage,
        deletedAt,
        priceMmk,
        product,
      ];
}

@JsonSerializable()
class Product extends Equatable {
  const Product({
    required this.id,
    required this.categoryId,
    required this.brandId,
    required this.nameEn,
    required this.nameMm,
    required this.slug,
    required this.featureImage,
    required this.category,
    required this.brand,
  });

  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: 'category_id')
  final int? categoryId;

  @JsonKey(name: 'brand_id')
  final int? brandId;

  @JsonKey(name: 'name_en')
  final String? nameEn;

  @JsonKey(name: 'name_mm')
  final String? nameMm;

  @JsonKey(name: "slug")
  final String? slug;

  @JsonKey(name: 'feature_image')
  final String? featureImage;

  @JsonKey(name: "category")
  final Brand? category;

  @JsonKey(name: "brand")
  final Brand? brand;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props => [
        id,
        categoryId,
        brandId,
        nameEn,
        nameMm,
        slug,
        featureImage,
        category,
        brand,
      ];
}

@JsonSerializable()
class Brand extends Equatable {
  const Brand({
    required this.id,
    required this.nameEn,
    required this.nameMm,
  });

  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: 'name_en')
  final String? nameEn;

  @JsonKey(name: 'name_mm')
  final String? nameMm;

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameMm,
      ];
}

@JsonSerializable()
class Link extends Equatable {
  const Link({
    required this.url,
    required this.label,
    required this.active,
  });

  @JsonKey(name: 'url')
  final String? url;

  @JsonKey(name: 'label')
  final String? label;

  @JsonKey(name: 'active')
  final bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  Map<String, dynamic> toJson() => _$LinkToJson(this);

  @override
  List<Object?> get props => [
        url,
        label,
        active,
      ];
}
