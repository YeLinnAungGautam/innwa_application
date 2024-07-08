// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionDetailResponse _$PromotionDetailResponseFromJson(
        Map<String, dynamic> json) =>
    PromotionDetailResponse(
      status: json['status'] as String?,
      promotionBannerImagePath: json['promotion_banner_image_path'] as String?,
      disImagePath: json['dis_image_path'] as String?,
      productFeatureImagePath: json['product_feature_image_path'] as String?,
      promotion: json['promotion'] == null
          ? null
          : PromotionDetail.fromJson(json['promotion'] as Map<String, dynamic>),
      products: json['products'] == null
          ? null
          : Products.fromJson(json['products'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PromotionDetailResponseToJson(
        PromotionDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'promotion_banner_image_path': instance.promotionBannerImagePath,
      'dis_image_path': instance.disImagePath,
      'product_feature_image_path': instance.productFeatureImagePath,
      'promotion': instance.promotion,
      'products': instance.products,
    };

PromotionDetail _$PromotionDetailFromJson(Map<String, dynamic> json) =>
    PromotionDetail(
      id: (json['id'] as num?)?.toInt(),
      nameEn: json['name_en'] as String?,
      nameMm: json['name_mm'] as String?,
      slug: json['slug'] as String?,
      featuredImage: json['featured_image'] as String?,
      bannerImage: json['banner_image'],
      descriptionEn: json['description_en'] as String?,
      descriptionMm: json['description_mm'] as String?,
    );

Map<String, dynamic> _$PromotionDetailToJson(PromotionDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_mm': instance.nameMm,
      'slug': instance.slug,
      'featured_image': instance.featuredImage,
      'banner_image': instance.bannerImage,
      'description_en': instance.descriptionEn,
      'description_mm': instance.descriptionMm,
    };

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
      currentPage: (json['current_page'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PromotionProductData.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstPageUrl: json['first_page_url'] as String?,
      from: (json['from'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
      lastPageUrl: json['last_page_url'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextPageUrl: json['next_page_url'] as String?,
      path: json['path'] as String?,
      perPage: (json['per_page'] as num?)?.toInt(),
      prevPageUrl: json['prev_page_url'],
      to: (json['to'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
      'first_page_url': instance.firstPageUrl,
      'from': instance.from,
      'last_page': instance.lastPage,
      'last_page_url': instance.lastPageUrl,
      'links': instance.links,
      'next_page_url': instance.nextPageUrl,
      'path': instance.path,
      'per_page': instance.perPage,
      'prev_page_url': instance.prevPageUrl,
      'to': instance.to,
      'total': instance.total,
    };

PromotionProductData _$PromotionProductDataFromJson(
        Map<String, dynamic> json) =>
    PromotionProductData(
      productPriceId: (json['product_price_id'] as num?)?.toInt(),
      productId: (json['product_id'] as num?)?.toInt(),
      disStartDate: json['dis_start_date'] == null
          ? null
          : DateTime.parse(json['dis_start_date'] as String),
      disEndDate: json['dis_end_date'] == null
          ? null
          : DateTime.parse(json['dis_end_date'] as String),
      disPrice: json['dis_price'] as String?,
      cashback: json['cashback'] as String?,
      gift: json['gift'] as String?,
      disImage: json['dis_image'],
      deletedAt: json['deleted_at'],
      priceMmk: (json['price_mmk'] as num?)?.toInt(),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PromotionProductDataToJson(
        PromotionProductData instance) =>
    <String, dynamic>{
      'product_price_id': instance.productPriceId,
      'product_id': instance.productId,
      'dis_start_date': instance.disStartDate?.toIso8601String(),
      'dis_end_date': instance.disEndDate?.toIso8601String(),
      'dis_price': instance.disPrice,
      'cashback': instance.cashback,
      'gift': instance.gift,
      'dis_image': instance.disImage,
      'deleted_at': instance.deletedAt,
      'price_mmk': instance.priceMmk,
      'product': instance.product,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num?)?.toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
      brandId: (json['brand_id'] as num?)?.toInt(),
      nameEn: json['name_en'] as String?,
      nameMm: json['name_mm'] as String?,
      slug: json['slug'] as String?,
      featureImage: json['feature_image'] as String?,
      category: json['category'] == null
          ? null
          : Brand.fromJson(json['category'] as Map<String, dynamic>),
      brand: json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'category_id': instance.categoryId,
      'brand_id': instance.brandId,
      'name_en': instance.nameEn,
      'name_mm': instance.nameMm,
      'slug': instance.slug,
      'feature_image': instance.featureImage,
      'category': instance.category,
      'brand': instance.brand,
    };

Brand _$BrandFromJson(Map<String, dynamic> json) => Brand(
      id: (json['id'] as num?)?.toInt(),
      nameEn: json['name_en'] as String?,
      nameMm: json['name_mm'] as String?,
    );

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_mm': instance.nameMm,
    };

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
      url: json['url'] as String?,
      label: json['label'] as String?,
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'url': instance.url,
      'label': instance.label,
      'active': instance.active,
    };
