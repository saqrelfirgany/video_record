import 'package:file_picker/file_picker.dart';

class FileModel {
  double progress;
  bool isDone;
  String error;
  PlatformFile platformFile;

  FileModel({
    this.progress = 0,
    this.isDone = false,
    this.error = '',
    required this.platformFile,
  });
}
