part of 'my_videos_cubit.dart';

@immutable
sealed class MyVideosState {}

final class MyVideosInitial extends MyVideosState {}

final class MyVideosLoading extends MyVideosState {}

final class MyVideosLoaded extends MyVideosState {
  final List<VideoModel> videos;
  final bool isVideoloading;
  final Set<String> selectedVideoIds;

  MyVideosLoaded({
    required this.videos,
    this.isVideoloading = false,
    this.selectedVideoIds = const {},
  });

  MyVideosLoaded copyWith({
    List<VideoModel>? videos,
    bool? isVideoloading,
    Set<String>? selectedVideoIds,
  }) {
    return MyVideosLoaded(
      videos: videos ?? this.videos,
      isVideoloading: isVideoloading ?? this.isVideoloading,
      selectedVideoIds: selectedVideoIds ?? this.selectedVideoIds,
    );
  }
}


final class MyVideosError extends MyVideosState {}
