/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/ayapay.png
  AssetGenImage get ayapay => const AssetGenImage('assets/images/ayapay.png');

  /// File path: assets/images/cod.png
  AssetGenImage get cod => const AssetGenImage('assets/images/cod.png');

  /// File path: assets/images/google_logo.png
  AssetGenImage get googleLogo =>
      const AssetGenImage('assets/images/google_logo.png');

  /// File path: assets/images/innwa_logo.png
  AssetGenImage get innwaLogo =>
      const AssetGenImage('assets/images/innwa_logo.png');

  /// File path: assets/images/logo_innwa.png
  AssetGenImage get logoInnwa =>
      const AssetGenImage('assets/images/logo_innwa.png');

  /// File path: assets/images/mm_flag.png
  AssetGenImage get mmFlag => const AssetGenImage('assets/images/mm_flag.png');

  /// File path: assets/images/mpu.png
  AssetGenImage get mpu => const AssetGenImage('assets/images/mpu.png');

  /// File path: assets/images/no-internet.png
  AssetGenImage get noInternet =>
      const AssetGenImage('assets/images/no-internet.png');

  /// File path: assets/images/shopping.jpg
  AssetGenImage get shopping =>
      const AssetGenImage('assets/images/shopping.jpg');

  /// File path: assets/images/us_flag.png
  AssetGenImage get usFlag => const AssetGenImage('assets/images/us_flag.png');

  /// File path: assets/images/visa.jpg
  AssetGenImage get visa => const AssetGenImage('assets/images/visa.jpg');

  /// File path: assets/images/worldmap.jpg
  AssetGenImage get worldmap =>
      const AssetGenImage('assets/images/worldmap.jpg');

  /// File path: assets/images/worldtravel.jpg
  AssetGenImage get worldtravel =>
      const AssetGenImage('assets/images/worldtravel.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [
        ayapay,
        cod,
        googleLogo,
        innwaLogo,
        logoInnwa,
        mmFlag,
        mpu,
        noInternet,
        shopping,
        usFlag,
        visa,
        worldmap,
        worldtravel
      ];
}

class $AssetsLogoGen {
  const $AssetsLogoGen();

  /// File path: assets/logo/google_logo.png
  AssetGenImage get googleLogo =>
      const AssetGenImage('assets/logo/google_logo.png');

  /// File path: assets/logo/logo_innwa.png
  AssetGenImage get logoInnwa =>
      const AssetGenImage('assets/logo/logo_innwa.png');

  /// List of all assets
  List<AssetGenImage> get values => [googleLogo, logoInnwa];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLogoGen logo = $AssetsLogoGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
