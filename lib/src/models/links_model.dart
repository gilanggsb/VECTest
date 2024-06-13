class Links {
  final String? apiUrl;
  final String? apiUrlVersion;
  final String? imageUrl;

  Links({
    this.apiUrl,
    this.apiUrlVersion,
    this.imageUrl,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        apiUrl: json["api_url"],
        apiUrlVersion: json["api_url_version"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "api_url": apiUrl,
        "api_url_version": apiUrlVersion,
        "image_url": imageUrl,
      };
}
