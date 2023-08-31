import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:misk_task/camera/camera_widget.dart';
import 'package:misk_task/services/camera_service.dart';

import 'body/upload_list_item.dart';
import 'controller/upload_cubit.dart';
import 'controller/upload_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadVideoCubit, UploadVideoState>(
      builder: (context, state) {
        final cubit = context.read<UploadVideoCubit>();
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: const Text('Upload'),
            elevation: 8,
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              cubit.fileModelList.isEmpty
                  ? const SizedBox()
                  : Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        children: List.generate(
                          cubit.fileModelList.length,
                          (index) => UploadListItem(
                            cubit: cubit,
                            fileModel: cubit.fileModelList[index],
                            index: index,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  cubit.pickingFileState();
                  await cubit.selectFile();
                  cubit.pickingFileDone();
                },
                child: const Text('Select File'),
              ),
              ElevatedButton(
                onPressed: () async {
                CameraService service =  CameraService();
                await service.initCamera();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CameraWidget(service:service),
                    ),
                  );
                },
                child: const Text('Record Video'),
              ),
              // ElevatedButton(
              //   onPressed: () async {
              //   CameraService service =  CameraService();
              //   await service.initCamera();
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (context) => CameraWidget(service:service),
              //       ),
              //     );
              //   },
              //   child: const Text('Record Video'),
              // ),
            ],
          ),
        );
      },
    );
  }
}
