import 'dart:io';

import 'package:flutter/material.dart';
import 'package:misk_task/home/body/upload_video.dart';
import 'package:misk_task/home/controller/file_model.dart';
import 'package:misk_task/home/controller/upload_cubit.dart';

class UploadListItem extends StatelessWidget {
  const UploadListItem({
    super.key,
    required this.fileModel,
    required this.cubit,
    required this.index,
  });

  final FileModel fileModel;
  final UploadVideoCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          // height: 220,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'File: ${fileModel.platformFile.name}',
                overflow: TextOverflow.ellipsis,
              ),
              UploadVideoWidget(fileModel: fileModel),
              fileModel.progress > 0 && !fileModel.isDone
                  ? const CircularProgressIndicator(strokeWidth: 3)
                  : ElevatedButton(
                      onPressed: fileModel.isDone
                          ? null
                          : () {
                              cubit.uploadVideo(
                                file: File(fileModel.platformFile.path!),
                                index: index,
                              );
                            },
                      child: Text(fileModel.isDone ? 'Done' : 'Upload File'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
