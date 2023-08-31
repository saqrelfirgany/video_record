import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:misk_task/home/controller/upload_cubit.dart';
import 'package:video_player/video_player.dart';

import '../repastory/storage_repository.dart';
import '../services/storage_service.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  VideoPlayerWidget(this.videoPath, {super.key});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // Create and initialize the video player controller
    _controller = VideoPlayerController.file(File(widget.videoPath));
    _initializeVideoPlayerFuture = _controller.initialize();
    // Loop the video playback
    _controller.setLooping(true);
    if (_controller.value.isInitialized && !_controller.value.isBuffering) {
      // Play the video if it is initialized and not buffering
      _controller.play();
    }
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose the video player controller
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(title: const Text('Video Player Example')),
      body: FutureBuilder<void>(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the video.
            return Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsetsDirectional.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
              onPressed: () {
                // Toggle the play and pause actions
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                final uploadVideoCubit = context.read<UploadVideoCubit>();
                uploadVideoCubit.uploadVideo(
                  file: File(widget.videoPath),
                  index: 0,
                );
                // context.read<CameraCubit>().startVideoRecording(context: context);
              },
              child: const Icon(Icons.done), // Use Icon widget instead of Text widget
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
