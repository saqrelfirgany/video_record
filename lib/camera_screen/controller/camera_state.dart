import 'package:camera/camera.dart';

// Define the state class
class CameraState {
  final bool isLoading;
  final bool isRecording;
  final bool isFrontCamera;
  final String? filePath;
  final CameraController? controller;

  CameraState({
    this.isLoading = true,
    this.isRecording = false,
    this.isFrontCamera = true,
    this.filePath,
    this.controller,
  });

  // Copy with method for updating state
  CameraState copyWith({
    bool? isLoading,
    bool? isRecording,
    bool? isFrontCamera,
    String? filePath,
    CameraController? controller,
  }) {
    return CameraState(
      isLoading: isLoading ?? this.isLoading,
      isRecording: isRecording ?? this.isRecording,
      isFrontCamera: isFrontCamera ?? this.isFrontCamera,
      filePath: filePath ?? this.filePath,
      controller: controller ?? this.controller,
    );
  }
}
