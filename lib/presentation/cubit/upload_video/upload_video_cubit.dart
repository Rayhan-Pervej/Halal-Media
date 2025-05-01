import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:video_player/video_player.dart';

part 'upload_video_state.dart';

class UploadVideoCubit extends Cubit<UploadVideoState> {
  UploadVideoCubit() : super(UploadVideoInitial());

  Future<void> init() async {
    emit(UploadVideoLoading());

    await Future.delayed(const Duration(seconds: 2)); // simulate API call

    emit(
      UploadVideoFormState(
        titleController: TextEditingController(),
        descriptionController: TextEditingController(),
        tagController: TextEditingController(),
        categories: ['Education', 'Entertainment', 'Business', 'News'],
        videoTypes: ['Short', 'Full', 'Tutorial', 'Live'],
        selectedTypes: [],
        tags: [],
      ),
    );
  }

  void pickVideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result?.files.single.path != null) {
      final file = File(result!.files.single.path!);
      final controller = VideoPlayerController.file(file);
      await controller.initialize();

      final current = state as UploadVideoFormState;
      emit(
        current.copyWith(videoFile: file, videoPlayerController: controller),
      );
    }
  }

  void togglePlayPause() {
    final current = state as UploadVideoFormState;
    final controller = current.videoPlayerController;
    if (controller == null) return;

    final isNowPlaying = !current.isPlaying;
    isNowPlaying ? controller.play() : controller.pause();

    emit(current.copyWith(isPlaying: isNowPlaying));
  }

  void toggleMute() {
    final current = state as UploadVideoFormState;
    final newMuted = !current.isMuted;
    current.videoPlayerController?.setVolume(newMuted ? 0 : 1);

    emit(current.copyWith(isMuted: newMuted));
  }

  void setCategory(String? category) {
    final current = state as UploadVideoFormState;
    emit(current.copyWith(selectedCategory: category));
  }

  void setVideoTypes(List<String> types) {
    final current = state as UploadVideoFormState;
    emit(current.copyWith(selectedTypes: types));
  }

  void addTag(String tag) {
    final current = state as UploadVideoFormState;
    if (tag.isNotEmpty && !current.tags.contains(tag)) {
      final newTags = [...current.tags, tag];
      current.tagController.clear();
      emit(current.copyWith(tags: newTags));
    }
  }

  void removeTag(String tag) {
    final current = state as UploadVideoFormState;
    final newTags = List<String>.from(current.tags)..remove(tag);
    emit(current.copyWith(tags: newTags));
  }

  Future<void> saveVideo({required bool isPublic}) async {
    final current = state as UploadVideoFormState;
    emit(
      current.copyWith(
        isUploading: true,
        uploadingType: isPublic ? UploadingType.public : UploadingType.private,
      ),
    );

    await Future.delayed(const Duration(seconds: 2)); // simulate upload

    emit(UploadVideoUploaded());

    emit(current.copyWith(isUploading: false, uploadingType: null));
  }

  @override
  Future<void> close() {
    final current = state;
    if (current is UploadVideoFormState) {
      current.titleController.dispose();
      current.descriptionController.dispose();
      current.tagController.dispose();
      current.videoPlayerController?.dispose();
    }
    return super.close();
  }
}
