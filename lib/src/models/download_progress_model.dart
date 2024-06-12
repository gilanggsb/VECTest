class DownloadProgressModel {
  final String? percentage;
  final double? progress;
  final int? receivedBytes;
  final int? totalBytes;

  DownloadProgressModel({
    this.percentage,
    this.progress,
    this.receivedBytes,
    this.totalBytes,
  });
}
