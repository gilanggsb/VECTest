extension StringExtensions on String? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }

  String _imageAssetPath(filename) => "assets/images/$filename";
  String _iconAssetPath(filename) => "assets/icons/$filename";
  String get toSvgImage => "${_imageAssetPath(this)}.svg";
  String get toPngImage => "${_imageAssetPath(this)}.png";
  String get toJpgImage => "${_imageAssetPath(this)}.jpg";
  String get toSvgIcon => "${_iconAssetPath(this)}.svg";
  String get toPngIcon => "${_iconAssetPath(this)}.png";
}
