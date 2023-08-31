// Import the packages
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../video_player_widget.dart';
import 'camera_state.dart';



// Define the cubit class
class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraState());

  // Method to load camera
  Future<void> loadCamera({required BuildContext context}) async {
    emit(state.copyWith(isLoading: true));
    List<CameraDescription>? cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      // Check if cameras is not empty
      ///
      /// Resolution Preset
      ///
      CameraController? controller;
      if (state.isFrontCamera) {
        controller = CameraController(cameras[1], ResolutionPreset.max);
      } else {
        controller = CameraController(cameras[0], ResolutionPreset.max);
      }
      await controller.initialize();
      // if (!mounted) {
      //   return;
      // }
      emit(state.copyWith(isLoading: false, controller: controller));
    } else {
      log('####################### No Camera #######################');
      showDialog(
        // Use showDialog instead of AlertDialog
        context: context,
        builder: (context) => const AlertDialog(content: Text('No Camera')),
      );
    }
  }

  // Method to toggle camera lens
  Future<void> toggleCameraLens() async {
    // Get the number of cameras
    final cameras = await availableCameras();
    final cameraCount = cameras.length;

    // Get the index of the current camera
    final currentCameraIndex = cameras.indexOf(state.controller!.description);

    // Calculate the index of the next camera
    int nextCameraIndex = currentCameraIndex + 1;

    // If the next camera index is out of bounds, use the first camera
    if (nextCameraIndex == cameraCount) {
      nextCameraIndex = 0;
    }

    // Get the next camera description
    final nextCameraDescription = cameras[nextCameraIndex];

    // Dispose the current controller
    if (state.controller != null) {
      await state.controller!.dispose();
    }

    // Initialize a new controller with the next camera description
    CameraController controller =
    CameraController(nextCameraDescription, ResolutionPreset.max);

    // Initialize the controller and update the state
    await controller.initialize();
    // if (!mounted) {
    //   return;
    // }
    emit(state.copyWith(
        controller: controller,
        isFrontCamera: !state.isFrontCamera)); // Toggle the isFrontCamera flag
  }

  // Method to start video recording
  Future<void> startVideoRecording({required BuildContext context}) async {
    if (state.isRecording) {
      final file = await state.controller?.stopVideoRecording();

      ///TODO:'Store the file'
      String? filePath = file?.path;
      log('####################### filePath:$filePath #######################');
      emit(state.copyWith(
        isRecording: false,
        filePath: filePath,
      ));
      if (filePath != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VideoPlayerWidget(filePath),
          ),
        );
      }
    } else {
      await state.controller?.prepareForVideoRecording();
      await state.controller?.startVideoRecording();
      emit(state.copyWith(isRecording: true));
    }
  }

  // Method to stop video recording
  Future<void> stopVideoRecording({required BuildContext context}) async {
    if (state.isRecording) {
      final file = await state.controller?.stopVideoRecording();
      String? filePath = file?.path;
      log('####################### filePath:$filePath #######################');
      emit(state.copyWith(
        isRecording: false,
        filePath: filePath,
      ));
      if (filePath != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VideoPlayerWidget(filePath),
          ),
        );
      }
    }
  }

  @override
  Future<void> close() async {
    // Dispose the controller before closing the cubit
    state.controller?.dispose();
    super.close();
  }
}
