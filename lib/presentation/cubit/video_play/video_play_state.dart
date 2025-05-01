part of 'video_play_cubit.dart';

@immutable
sealed class VideoPlayState {}

final class VideoPlayInitial extends VideoPlayState {}

final class VideoPlayLoading extends VideoPlayState {}

final class VideoPlayLoaded extends VideoPlayState {
  final VideoModel videos;
  final bool isSubscribeLoading;
  final bool isSubscribed;
  final bool isDescriptionSelected;
  final bool isFavorite;

  VideoPlayLoaded({
    required this.videos,
    required this.isSubscribed,
    this.isSubscribeLoading = false,
    this.isDescriptionSelected = true,
    required this.isFavorite,
  });

  VideoPlayLoaded copyWith({
    VideoModel? videos,
    bool? isSubscribeLoading,
    bool? isSubscribed,
    bool? isDescriptionSelected,
    bool? isFavorite,
  }) {
    return VideoPlayLoaded(
      videos: videos ?? this.videos,
      isSubscribeLoading: isSubscribeLoading ?? this.isSubscribeLoading,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      isDescriptionSelected:
          isDescriptionSelected ?? this.isDescriptionSelected,
          isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

final class VideoPlayError extends VideoPlayState {
  final String message;
  VideoPlayError(this.message);
}
