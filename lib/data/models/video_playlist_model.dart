import 'video_model.dart';

class VideoPlaylistModel {
  final String id;
  final String title;
  final String privacy;
  final List<VideoModel> videos;

  VideoPlaylistModel({
    required this.id,
    required this.title,
    required this.privacy,
    required this.videos,
  });

  String get thumbnail1 => videos.length > 0 ? videos[0].thumbnail : '';
  String get thumbnail2 => videos.length > 1 ? videos[1].thumbnail : '';
  String get thumbnail3 => videos.length > 2 ? videos[2].thumbnail : '';

  // ✅ Add this method to allow partial updates
  VideoPlaylistModel copyWith({
    String? id,
    String? title,
    String? privacy,
    List<VideoModel>? videos,
  }) {
    return VideoPlaylistModel(
      id: id ?? this.id,
      title: title ?? this.title,
      privacy: privacy ?? this.privacy,
      videos: videos ?? this.videos,
    );
  }
}
