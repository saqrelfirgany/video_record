import 'package:equatable/equatable.dart';

class UploadVideoState extends Equatable {
  final bool isPickFileLoading;
  final bool isPickFileDone;
  final bool isProgress;
  final bool isDone;
  final bool isError;

  const UploadVideoState({
    this.isPickFileLoading = false,
    this.isPickFileDone = false,
    this.isProgress = false,
    this.isDone = false,
    this.isError = false,
  });

  // Copy the state with new values
  UploadVideoState copyWith({
    bool? isPickFileLoading,
    bool? isPickFileDone,
    bool? isProgress,
    bool? isDone,
    bool? isError,
  }) {
    return UploadVideoState(
      isPickFileLoading: isPickFileLoading ?? this.isPickFileLoading,
      isPickFileDone: isPickFileDone ?? this.isPickFileDone,
      isProgress: isProgress ?? this.isProgress,
      isDone: isDone ?? this.isDone,
      isError: isError ?? this.isError,
    );
  }

// Copy the state with new values
  UploadVideoState copyWithIsProgress({
    required bool isProgress,
  }) {
    return UploadVideoState(
      isProgress: isProgress,
    );
  }

// Copy the state with new values
  UploadVideoState copyWithPickFileLoading({
    required bool isPickFileLoading,
    bool? isProgress,
  }) {
    return UploadVideoState(
      isPickFileLoading: isPickFileLoading,
      isProgress: isProgress ?? this.isProgress,
    );
  }

// Copy the state with new values
  UploadVideoState copyWithPickFileDone({
    required bool isPickFileDone,
    bool? isProgress,
  }) {
    return UploadVideoState(
      isPickFileDone: isPickFileDone,
      isProgress: isProgress ?? this.isProgress,
    );
  }

  @override
  List<Object?> get props => [
    isPickFileLoading,
    isPickFileDone,
    isProgress,
    isDone,
    isError,
  ];
}
