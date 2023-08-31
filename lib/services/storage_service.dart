import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<UploadTask> uploadVideo(File file) async {
    final fileName = path.basename(file.path);
    final destination = 'videos/$fileName';
    final ref = _storage.ref(destination);
    final task = ref.putFile(file);
    return task;
  }
}

