extension StringExtensions on String? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }

  String imageAssetPath(filename) => "assets/images/$filename";
  String iconAssetPath(filename) => "assets/icons/$filename";
  String get toSvgImage => "${imageAssetPath(this)}.svg";
  String get toPngImage => "${imageAssetPath(this)}.png";
  String get toJpgImage => "${imageAssetPath(this)}.jpg";
  String get toSvgIcon => "${iconAssetPath(this)}.svg";
  String get toPngIcon => "${iconAssetPath(this)}.png";
}
