import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:misk_task/home/controller/upload_state.dart';

import '../../repastory/storage_repository.dart';
import 'file_model.dart';

class UploadVideoCubit extends Cubit<UploadVideoState> {
  final StorageRepository _repository;
  List<int> currentFileIndex = [];
  int fileIndex = 0;
  List<FileModel> fileModelList = [];

  UploadVideoCubit(this._repository) : super(const UploadVideoState());

  Future selectFile() async {
    await FilePicker.platform.pickFiles().then((value) {
      if (value != null) {
        fileModelList.add(
          FileModel(platformFile: value.files.first),
        );
      }
    });
  }

  void pickingFileDone() {
    final newState = state.copyWithPickFileDone(isPickFileDone: true);
    emit(newState);
  }

  void pickingFileState() {
    final newState = state.copyWithPickFileLoading(isPickFileLoading: true);
    emit(newState);
  }

  void isProgressState() {
    final newState = state.copyWith(isProgress: true);
    emit(newState);
  }

  Future<void> uploadVideo({required File file, required int index}) async {
    currentFileIndex.add(index);

    try {
      // Get the upload task from the repository
      final task = await _repository.uploadVideo(file);

      // Listen to the snapshot events of the task
      task.snapshotEvents.listen((event) {
        final progressState = state.copyWithIsProgress(isProgress: false);
        emit(progressState);

        // Calculate the progress percentage
        final progress = event.bytesTransferred.toDouble() / event.totalBytes.toDouble();

        fileModelList[index].progress = progress;
        final newState = state.copyWithIsProgress(isProgress: true);
        emit(newState);
      });
      // Wait for the task to complete
      await task;

      // Emit a new state with the done flag set to true
      fileModelList[index].isDone = true;
      emit(state.copyWith(isDone: true, isProgress: false));
    } catch (e) {
      // Emit a new state with the error message
      fileModelList[index].error = e.toString();
      emit(state.copyWith(isError: true, isProgress: false));
    }
  }
}
