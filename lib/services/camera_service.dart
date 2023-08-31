import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraService {
  late CameraController controller;
  late Future<void> initializeControllerFuture = controller.initialize();

  // Initialize the camera controller
  Future<void> initCamera() async {
    // Get a list of available cameras
    final cameras = await availableCameras();

    // Get a specific camera from the list
    final firstCamera = cameras.first;

    // Create a camera controller
    controller = CameraController(
      // Get a specific camera from the list of available cameras.
      firstCamera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, you need to initialize the controller. This returns a Future.
    initializeControllerFuture = controller.initialize();
  }

  // Start recording a video
  Future<String> startRecording() async {
    // Wait until the controller is initialized before recording.
    await initializeControllerFuture;

    // Construct the path where the image should be saved using the
    // pattern package.
    final path = join(
      // Store the video in a temporary directory.
      (await getTemporaryDirectory()).path,
      '${DateTime.now()}.mp4',
    );

    // Attempt to start recording.
    await controller.startVideoRecording();

    // Return the path of the recorded video
    return path;
  }

  // Stop recording a video
  Future<void> stopRecording() async {
    // Wait until the controller is initialized before stopping.
    await initializeControllerFuture;

    // Attempt to stop recording.
    await controller.stopVideoRecording();
  }

  // Dispose the camera controller
  void dispose() {
    controller.dispose();
  }
}
