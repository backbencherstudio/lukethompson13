// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/app_logo.png
  AssetGenImage get appLogo => const AssetGenImage('assets/icons/app_logo.png');

  /// File path: assets/icons/arrow_left.png
  AssetGenImage get arrowLeft =>
      const AssetGenImage('assets/icons/arrow_left.png');

  /// File path: assets/icons/back_arrow.png
  AssetGenImage get backArrow =>
      const AssetGenImage('assets/icons/back_arrow.png');

  /// File path: assets/icons/building.svg
  String get building => 'assets/icons/building.svg';

  /// File path: assets/icons/client_review_logo.png
  AssetGenImage get clientReviewLogo =>
      const AssetGenImage('assets/icons/client_review_logo.png');

  /// File path: assets/icons/clock.png
  AssetGenImage get clock => const AssetGenImage('assets/icons/clock.png');

  /// File path: assets/icons/crown-alt.svg
  String get crownAlt => 'assets/icons/crown-alt.svg';

  /// File path: assets/icons/detention.png
  AssetGenImage get detention =>
      const AssetGenImage('assets/icons/detention.png');

  /// File path: assets/icons/email.png
  AssetGenImage get email => const AssetGenImage('assets/icons/email.png');

  /// File path: assets/icons/google.png
  AssetGenImage get google => const AssetGenImage('assets/icons/google.png');

  /// File path: assets/icons/home.png
  AssetGenImage get home => const AssetGenImage('assets/icons/home.png');

  /// File path: assets/icons/lock-icon.svg
  String get lockIcon => 'assets/icons/lock-icon.svg';

  /// File path: assets/icons/logo_icons.png
  AssetGenImage get logoIcons =>
      const AssetGenImage('assets/icons/logo_icons.png');

  /// File path: assets/icons/mastercard-logo.svg
  String get mastercardLogo => 'assets/icons/mastercard-logo.svg';

  /// File path: assets/icons/onboarding_screen.png
  AssetGenImage get onboardingScreen =>
      const AssetGenImage('assets/icons/onboarding_screen.png');

  /// File path: assets/icons/play_store_512.png
  AssetGenImage get playStore512 =>
      const AssetGenImage('assets/icons/play_store_512.png');

  /// File path: assets/icons/profile.png
  AssetGenImage get profile => const AssetGenImage('assets/icons/profile.png');

  /// File path: assets/icons/reports.png
  AssetGenImage get reports => const AssetGenImage('assets/icons/reports.png');

  /// File path: assets/icons/revenue_icon.png
  AssetGenImage get revenueIcon =>
      const AssetGenImage('assets/icons/revenue_icon.png');

  /// File path: assets/icons/revenue_lost.png
  AssetGenImage get revenueLost =>
      const AssetGenImage('assets/icons/revenue_lost.png');

  /// File path: assets/icons/stops.png
  AssetGenImage get stops => const AssetGenImage('assets/icons/stops.png');

  /// File path: assets/icons/submittedIcon.png
  AssetGenImage get submittedIcon =>
      const AssetGenImage('assets/icons/submittedIcon.png');

  /// File path: assets/icons/tick_mark.svg
  String get tickMark => 'assets/icons/tick_mark.svg';

  /// File path: assets/icons/worst.png
  AssetGenImage get worst => const AssetGenImage('assets/icons/worst.png');

  /// File path: assets/icons/worst_stop.png
  AssetGenImage get worstStop =>
      const AssetGenImage('assets/icons/worst_stop.png');

  /// List of all assets
  List<dynamic> get values => [
    appLogo,
    arrowLeft,
    backArrow,
    building,
    clientReviewLogo,
    clock,
    crownAlt,
    detention,
    email,
    google,
    home,
    lockIcon,
    logoIcons,
    mastercardLogo,
    onboardingScreen,
    playStore512,
    profile,
    reports,
    revenueIcon,
    revenueLost,
    stops,
    submittedIcon,
    tickMark,
    worst,
    worstStop,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/pickUp.png
  AssetGenImage get pickUp => const AssetGenImage('assets/images/pickUp.png');

  /// File path: assets/images/placeholder_image.jpg
  AssetGenImage get placeholderImage =>
      const AssetGenImage('assets/images/placeholder_image.jpg');

  /// File path: assets/images/subscription_success.png
  AssetGenImage get subscriptionSuccess =>
      const AssetGenImage('assets/images/subscription_success.png');

  /// File path: assets/images/user.png
  AssetGenImage get user => const AssetGenImage('assets/images/user.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    pickUp,
    placeholderImage,
    subscriptionSuccess,
    user,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
