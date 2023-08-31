import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:misk_task/camera/video_player_widget.dart';
import 'package:misk_task/services/camera_service.dart';

class CameraWidget extends StatefulWidget {
  final CameraService service;

  const CameraWidget({super.key, required this.service});

  @override
  State<CameraWidget> createState() => CameraWidgetState();
}

class CameraWidgetState extends State<CameraWidget> {
  // final CameraService _service = CameraService();
  bool _isRecording = false;
  String? _videoPath;

  @override
  void initState() {
    // sadsad();

    super.initState();
    // Initialize the camera service when the widget is created
  }

  // Future<void> sadsad() async {
  //   await _service.initCamera();
  // }

  @override
  void dispose() {
    super.dispose();
    // Dispose the camera service when the widget is destroyed
    widget.service.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera Example')),
      body: FutureBuilder<void>(
        future: widget.service.initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Stack(
              children: [
                CameraPreview(widget.service.controller),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () async {
                      if (_isRecording) {
                        // Stop recording and save the video path
                        await widget.service.stopRecording();
                        setState(() {
                          _isRecording = false;
                        });
                      } else {
                        // Start recording and get the video path
                        final path = await widget.service.startRecording();
                        setState(() {
                          _isRecording = true;
                          _videoPath = path;
                        });
                      }
                    },
                  ),
                ),
              ],
            );
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          if (_videoPath != null) {
            // Navigate to the video player widget with the video path
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoPlayerWidget(_videoPath!),
              ),
            );
          }
        },
      ),
    );
  }
}
