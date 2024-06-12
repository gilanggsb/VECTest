import './models.dart';

class DownloadFileModel {
  final String fullFileUrl;
  final String fileNameWithExt;
  final Function(DownloadProgressModel) downloadProgress;
  final bool deleteOnError;

  DownloadFileModel({
    required this.fullFileUrl,
    required this.fileNameWithExt,
    required this.downloadProgress,
    this.deleteOnError = true,
  });
}
