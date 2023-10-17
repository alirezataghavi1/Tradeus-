/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImageGen {
  const $AssetsImageGen();

  $AssetsImageHomeCardGen get homeCard => const $AssetsImageHomeCardGen();
  $AssetsImageLogoGen get logo => const $AssetsImageLogoGen();
  $AssetsImageSplashGen get splash => const $AssetsImageSplashGen();
}

class $AssetsImageHomeCardGen {
  const $AssetsImageHomeCardGen();

  /// File path: assets/image/homeCard/cardpic.jpg
  AssetGenImage get cardpic =>
      const AssetGenImage('assets/image/homeCard/cardpic.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [cardpic];
}

class $AssetsImageLogoGen {
  const $AssetsImageLogoGen();

  /// File path: assets/image/logo/logo.jpg
  AssetGenImage get logo => const AssetGenImage('assets/image/logo/logo.jpg');

  /// File path: assets/image/logo/lunchIcon.png
  AssetGenImage get lunchIcon =>
      const AssetGenImage('assets/image/logo/lunchIcon.png');

  /// List of all assets
  List<AssetGenImage> get values => [logo, lunchIcon];
}

class $AssetsImageSplashGen {
  const $AssetsImageSplashGen();

  /// File path: assets/image/splash/splash.png
  AssetGenImage get splash =>
      const AssetGenImage('assets/image/splash/splash.png');

  /// File path: assets/image/splash/splashIcon.png
  AssetGenImage get splashIcon =>
      const AssetGenImage('assets/image/splash/splashIcon.png');

  /// List of all assets
  List<AssetGenImage> get values => [splash, splashIcon];
}

class Assets {
  Assets._();

  static const $AssetsImageGen image = $AssetsImageGen();
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
