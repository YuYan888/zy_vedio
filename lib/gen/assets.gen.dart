/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetImagesGen {
  const $AssetImagesGen();

  /// File path: asset/images/add.png
  AssetGenImage get add => const AssetGenImage('asset/images/add.png');

  /// File path: asset/images/avatar.jpg
  AssetGenImage get avatar => const AssetGenImage('asset/images/avatar.jpg');

  /// File path: asset/images/clock.png
  AssetGenImage get clock => const AssetGenImage('asset/images/clock.png');

  /// File path: asset/images/close.png
  AssetGenImage get close => const AssetGenImage('asset/images/close.png');

  /// File path: asset/images/default_photo.png
  AssetGenImage get defaultPhoto =>
      const AssetGenImage('asset/images/default_photo.png');

  /// File path: asset/images/edit.png
  AssetGenImage get edit => const AssetGenImage('asset/images/edit.png');

  /// File path: asset/images/flash_off.png
  AssetGenImage get flashOff =>
      const AssetGenImage('asset/images/flash_off.png');

  /// File path: asset/images/flash_on.png
  AssetGenImage get flashOn => const AssetGenImage('asset/images/flash_on.png');

  /// File path: asset/images/gallery.png
  AssetGenImage get gallery => const AssetGenImage('asset/images/gallery.png');

  /// File path: asset/images/img.png
  AssetGenImage get img => const AssetGenImage('asset/images/img.png');

  /// File path: asset/images/img_1.png
  AssetGenImage get img1 => const AssetGenImage('asset/images/img_1.png');

  /// File path: asset/images/lock.png
  AssetGenImage get lock => const AssetGenImage('asset/images/lock.png');

  /// File path: asset/images/play.png
  AssetGenImage get play => const AssetGenImage('asset/images/play.png');

  /// File path: asset/images/rotate.png
  AssetGenImage get rotate => const AssetGenImage('asset/images/rotate.png');
}

class $AssetVideosGen {
  const $AssetVideosGen();

  /// File path: asset/videos/test.flv
  String get test => 'asset/videos/test.flv';
}

class Assets {
  Assets._();

  static const $AssetImagesGen images = $AssetImagesGen();
  static const $AssetVideosGen videos = $AssetVideosGen();
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

  String get path => _assetName;

  String get keyName => _assetName;
}
