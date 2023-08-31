import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../services/storage_service.dart';

class StorageRepository {
  final StorageService _service;

  StorageRepository(this._service);

  Future<UploadTask> uploadVideo(File file) async {
    return _service.uploadVideo(file);
  }
}
