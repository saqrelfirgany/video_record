
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:misk_task/home/controller/file_model.dart';
import 'package:misk_task/home/controller/upload_cubit.dart';
import 'package:misk_task/home/controller/upload_state.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


class UploadVideoWidget extends StatelessWidget {
  const UploadVideoWidget({super.key, required this.fileModel});

  final FileModel fileModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadVideoCubit, UploadVideoState>(
      builder: (context, state) {
        if (fileModel.error.isNotEmpty) {
          return Center(
            child: Text(
              'Error: ${fileModel.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (fileModel.isDone) {
          // Show a success message if the upload is done
          return const Center(
            child: Text(
              'Upload successful!',
              style: TextStyle(color: Colors.green),
            ),
          );
        } else {
          // Show a progress indicator if the upload is in progress
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 90,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2500,
                  animateFromLastPercent: true,
                  percent: fileModel.progress,
                  center: Text(
                    '${(fileModel.progress * 100).toInt()}%',
                  ),
                  barRadius: const Radius.circular(8),
                  progressColor: (fileModel.progress * 100) < 50 ? Colors.red : Colors.green,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
