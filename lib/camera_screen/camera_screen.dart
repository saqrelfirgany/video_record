// Define the UI class
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/camera_cubit.dart';
import 'controller/camera_state.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CameraCubit>(
      create: (context) => CameraCubit()..loadCamera(context: context),
      child: BlocBuilder<CameraCubit, CameraState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Camera Screen'),
            ),
            body: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : CameraPreview(state.controller!),
            floatingActionButton: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: () {
                      context.read<CameraCubit>().toggleCameraLens();
                    },
                    child: const Icon(Icons.cameraswitch), // Use Icon widget instead of Text widget
                  ),
                  const SizedBox(width: 16), // Use SizedBox widget instead of Padding widget
                  FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: () {
                      context.read<CameraCubit>().startVideoRecording(context: context);
                    },
                    child: Icon(
                      state.isRecording ? Icons.stop : Icons.videocam,
                    ), // Use Icon widget instead of Text widget
                  ),
                  const SizedBox(width: 16), // Use SizedBox widget instead of Padding widget
                ],
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }
}
