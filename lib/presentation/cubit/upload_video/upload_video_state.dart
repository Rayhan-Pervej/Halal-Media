part of 'upload_video_cubit.dart';

enum UploadingType { public, private }

@immutable
sealed class UploadVideoState {}

class UploadVideoInitial extends UploadVideoState {}

class UploadVideoLoading extends UploadVideoState {}

class UploadVideoFormState extends UploadVideoState {
  final File? videoFile;
  final VideoPlayerController? videoPlayerController;
  final bool isPlaying;
  final bool isMuted;

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController tagController;

  final List<String> categories;
  final String? selectedCategory;

  final List<String> videoTypes;
  final List<String> selectedTypes;

  final List<String> tags;
  final bool isUploading;

  final UploadingType? uploadingType;
  UploadVideoFormState({
    this.videoFile,
    this.videoPlayerController,
    this.isPlaying = false,
    this.isMuted = true,
    required this.titleController,
    required this.descriptionController,
    required this.tagController,
    required this.categories,
    required this.videoTypes,
    this.selectedCategory,
    required this.selectedTypes,
    required this.tags,
    this.isUploading = false,
    this.uploadingType,
  });

  UploadVideoFormState copyWith({
    File? videoFile,
    VideoPlayerController? videoPlayerController,
    bool? isPlaying,
    bool? isMuted,
    TextEditingController? titleController,
    TextEditingController? descriptionController,
    TextEditingController? tagController,
    List<String>? categories,
    List<String>? videoTypes,
    String? selectedCategory,
    List<String>? selectedTypes,
    List<String>? tags,
    bool? isUploading,
    UploadingType? uploadingType,
  }) {
    return UploadVideoFormState(
      videoFile: videoFile ?? this.videoFile,
      videoPlayerController:
          videoPlayerController ?? this.videoPlayerController,
      isPlaying: isPlaying ?? this.isPlaying,
      isMuted: isMuted ?? this.isMuted,
      titleController: titleController ?? this.titleController,
      descriptionController:
          descriptionController ?? this.descriptionController,
      tagController: tagController ?? this.tagController,
      categories: categories ?? this.categories,
      videoTypes: videoTypes ?? this.videoTypes,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedTypes: selectedTypes ?? this.selectedTypes,
      tags: tags ?? this.tags,
      isUploading: isUploading ?? this.isUploading,
      uploadingType: uploadingType ?? this.uploadingType,
    );
  }
}

class UploadVideoUploaded extends UploadVideoState {}

class UploadVideoError extends UploadVideoState {
  final String message;
  UploadVideoError(this.message);
}
