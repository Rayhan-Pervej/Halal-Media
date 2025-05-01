class VideoModel {
  final String channelName;
  final double channelId;
  final String videoId;
  final String thumbnail;
  final String avatar;
  final String title;
  final String views;
  final String date;
  final String type;
  final bool isFavorite;
  final String description;
  final bool isSubscribed;
  final String videoUrl;
  final String watchDate;
  final String status;
  final String? notes;

  VideoModel({
    required this.channelId,
    required this.channelName,
    required this.thumbnail,
    required this.avatar,
    required this.title,
    required this.views,
    required this.date,
    required this.type,
    this.isFavorite = false,
    required this.videoId,
    required this.description,
    required this.isSubscribed,
    required this.videoUrl,
    required this.watchDate,
    this.notes,
    required this.status,
  });
}
