import 'package:halal_media/data/models/video_model.dart';

class VideoRepo {
  Future<List<VideoModel>> fetchVideos() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Return mock data
    return [
      VideoModel(
        channelName: 'Learn Al Quran',
        channelId: 1,
        thumbnail: "assets/thumbnails/thumbnail_1.png",
        avatar: "assets/icons/avatar_1.png",
        title: "Bulbuli | Coke Studio Bangla | Season One | Ritu Raj X Nandita",
        views: "1.5M",
        date: "2 days ago",
        description: " adfahdf ajdlfkja df",
        type: "surah",
        isFavorite: true,
        videoId: "1",
        isSubscribed: true,
        videoUrl: "https://www.youtube.com/watch?v=2rV1rUhPAWs",
        watchDate: '20/04/2025',
        status: 'active',
      ),
      VideoModel(
        channelName: 'Learn Al Quran',
        channelId: 1,
        thumbnail: "assets/thumbnails/thumbnail_1.png",
        avatar: "assets/icons/avatar_1.png",
        title: "Bulbuli | Coke Studio Bangla | Season One | Ritu Raj X Nandita",
        views: "",
        date: "2 days ago",
        description: " adfahdf ajdlfkja df",
        type: "surah",
        isFavorite: false,
        videoId: "3",
        isSubscribed: false,
        videoUrl: "",
        watchDate: ' ',
        status: 'pending',
      ),
      VideoModel(
        channelName: 'Learn Hadith',
        channelId: 2,
        thumbnail: "assets/thumbnails/thumbnail_2.png",
        avatar: "assets/icons/avatar_1.png",
        title: "kamon acho | kothai acho",
        views: "1.5M",
        date: "2 days ago",
        description: "falkdjhae oaefaodjf ",
        type: 'quran',
        isFavorite: false,
        videoId: "2",
        isSubscribed: false,
        watchDate: '28/04/2025',
        videoUrl: "https://www.youtube.com/watch?v=9sND46NSQs4",
        status: 'active',
      ),
      // Add more dummy videos here
    ];
  }

  Future<List<VideoModel>> fetchVideosByQuery(String query) async {
    await Future.delayed(Duration(seconds: 3)); // Simulated network delay

    final allVideos = [
      VideoModel(
        channelName: 'Learn Al Quran',
        channelId: 1,
        thumbnail: "assets/thumbnails/thumbnail_1.png",
        avatar: "assets/icons/avatar_1.png",
        title: "Bulbuli | Coke Studio Bangla | Season One | Ritu Raj X Nandita",
        description: "dhfad adkhfalkdjf ",
        views: "1.5M",
        date: "2 days ago",
        type: "surah",
        isFavorite: true,
        videoId: "1", // ID = "1"
        isSubscribed: true,
        watchDate: '20/04/2025',
        videoUrl: "https://www.youtube.com/watch?v=2rV1rUhPAWs",
        status: 'active',
      ),
      VideoModel(
        channelName: 'Learn Al Quran',
        channelId: 1,
        thumbnail: "assets/thumbnails/thumbnail_1.png",
        avatar: "assets/icons/avatar_1.png",
        title: "Bulbuli | Coke Studio Bangla | Season One | Ritu Raj X Nandita",
        views: "",
        date: "2 days ago",
        description: " adfahdf ajdlfkja df",
        type: "surah",
        isFavorite: false,
        videoId: "3",
        isSubscribed: false,
        videoUrl: "",
        watchDate: ' ',
        status: 'pending',
      ),
      VideoModel(
        channelName: 'Learn Al Quran',
        channelId: 2,
        thumbnail: "assets/thumbnails/thumbnail_1.png",
        avatar: "assets/icons/avatar_1.png",
        title: "Surah AR Rahman | Beautiful Recitation",
        views: "900K",
        date: "5 days ago",
        type: 'quran',
        isFavorite: false,
        description: "2384 dfh8y34 dfadf",
        videoId: "2", // ID = "2"
        isSubscribed: false,
        videoUrl: "https://www.youtube.com/watch?v=9sND46NSQs4",
        watchDate: '28/04/2025',
        status: 'active',
      ),
    ];

    if (query == 'all') {
      return allVideos;
    }

    // Find videos with EXACT videoId match (case-sensitive)
    return allVideos.where((video) => video.videoId == query).toList();
  }

  Future<List<VideoModel>> fetchVideosByStatus(String query) async {
    await Future.delayed(Duration(seconds: 3)); // Simulated network delay

    final allVideos = [
      VideoModel(
        channelName: 'Learn Al Quran',
        channelId: 1,
        thumbnail: "assets/thumbnails/thumbnail_1.png",
        avatar: "assets/icons/avatar_1.png",
        title: "Bulbuli | Coke Studio Bangla | Season One | Ritu Raj X Nandita",
        description: "dhfad adkhfalkdjf ",
        views: "1.5M",
        date: "2 days ago",
        type: "surah",
        isFavorite: true,
        videoId: "1", // ID = "1"
        isSubscribed: true,
        watchDate: '20/04/2025',
        videoUrl: "https://www.youtube.com/watch?v=2rV1rUhPAWs",
        status: 'active',
      ),
      VideoModel(
        channelName: 'Learn Al Quran',
        channelId: 1,
        thumbnail: "assets/thumbnails/thumbnail_1.png",
        avatar: "assets/icons/avatar_1.png",
        title: "Bulbuli | Coke Studio Bangla | Season One | Ritu Raj X Nandita",
        views: "",
        date: "2 days ago",
        description: " adfahdf ajdlfkja df",
        type: "surah",
        isFavorite: false,
        videoId: "3",
        isSubscribed: false,
        videoUrl: "",
        watchDate: ' ',
        status: 'pending',
      ),
      VideoModel(
        channelName: 'Learn Al Quran',
        channelId: 2,
        thumbnail: "assets/thumbnails/thumbnail_1.png",
        avatar: "assets/icons/avatar_1.png",
        title: "Surah AR Rahman | Beautiful Recitation",
        views: "900K",
        date: "5 days ago",
        type: 'quran',
        isFavorite: false,
        description: "2384 dfh8y34 dfadf",
        videoId: "2", // ID = "2"
        isSubscribed: false,
        videoUrl: "https://www.youtube.com/watch?v=9sND46NSQs4",
        watchDate: '28/04/2025',
        status: 'drafts',
      ),
    ];

    if (query == 'all') {
      return allVideos;
    }

    // Find videos with EXACT videoId match (case-sensitive)
    return allVideos.where((video) => video.status == query).toList();
  }

  Future<List<VideoModel>> fetchVideosByDate(String query) async {
    await Future.delayed(Duration(seconds: 3)); // Simulated network delay

    final allVideos = [
      VideoModel(
        channelName: 'Learn Al Quran',
        channelId: 1,
        thumbnail: "assets/thumbnails/thumbnail_1.png",
        avatar: "assets/icons/avatar_1.png",
        title: "Bulbuli | Coke Studio Bangla | Season One | Ritu Raj X Nandita",
        description: "dhfad adkhfalkdjf ",
        views: "1.5M",
        date: "2 days ago",
        type: "surah",
        isFavorite: true,
        videoId: "1", // ID = "1"
        isSubscribed: true,
        watchDate: '20/04/2025',
        videoUrl: "https://www.youtube.com/watch?v=2rV1rUhPAWs",
        status: "active",
      ),
      VideoModel(
        channelName: 'Learn Al Quran',
        channelId: 2,
        thumbnail: "assets/thumbnails/thumbnail_1.png",
        avatar: "assets/icons/avatar_1.png",
        title: "Surah AR Rahman | Beautiful Recitation",
        views: "900K",
        date: "5 days ago",
        type: 'quran',
        isFavorite: false,
        description: "2384 dfh8y34 dfadf",
        videoId: "2", // ID = "2"
        isSubscribed: false,
        videoUrl: "https://www.youtube.com/watch?v=9sND46NSQs4",
        watchDate: '28/04/2025',
        status: 'active',
      ),
    ];

    if (query == 'all') {
      return allVideos;
    }

    // Find videos with EXACT videoId match (case-sensitive)
    return allVideos.where((video) => video.watchDate == query).toList();
  }

  Future<List<VideoModel>> fetchNotesByVideoId(String query) async {
    await Future.delayed(Duration(seconds: 3)); // Simulated network delay

    final allVideos = [
      VideoModel(
        channelName: 'Learn Al Quran',
        channelId: 1,
        thumbnail: "assets/thumbnails/thumbnail_1.png",
        avatar: "assets/icons/avatar_1.png",
        title: "Bulbuli | Coke Studio Bangla | Season One | Ritu Raj X Nandita",
        description: "dhfad adkhfalkdjf ",
        views: "1.5M",
        date: "2 days ago",
        type: "surah",
        isFavorite: true,
        videoId: "1", // ID = "1"
        isSubscribed: true,
        watchDate: '20/04/2025',
        videoUrl: "https://www.youtube.com/watch?v=2rV1rUhPAWs",
        status: "active",
        notes: 'Nadkfalkdf akldjfakdhflka dfhlakdf',
      ),
      VideoModel(
        channelName: 'Learn Al Quran',
        channelId: 2,
        thumbnail: "assets/thumbnails/thumbnail_1.png",
        avatar: "assets/icons/avatar_1.png",
        title: "Surah AR Rahman | Beautiful Recitation",
        views: "900K",
        date: "5 days ago",
        type: 'quran',
        isFavorite: false,
        description: "2384 dfh8y34 dfadf",
        videoId: "2", // ID = "2"
        isSubscribed: false,
        videoUrl: "https://www.youtube.com/watch?v=9sND46NSQs4",
        watchDate: '28/04/2025',
        status: 'active',
        notes: 'hi hello how are you ai m fine fakdfh',
      ),
      VideoModel(
        channelName: 'Learn Al Quran',
        channelId: 2,
        thumbnail: "assets/thumbnails/thumbnail_1.png",
        avatar: "assets/icons/avatar_1.png",
        title: "Surah AR Rahman | Beautiful Recitation",
        views: "900K",
        date: "5 days ago",
        type: 'quran',
        isFavorite: false,
        description: "2384 dfh8y34 dfadf",
        videoId: "3", // ID = "2"
        isSubscribed: false,
        videoUrl: "https://www.youtube.com/watch?v=9sND46NSQs4",
        watchDate: '28/04/2025',
        status: 'active',
        notes:
            'hi hello how are you ai m fine fakdfh adfa df adfhadkjf akdfhhd akjdhf akdfh akd akldf akdhf akdhfadhfadihfa ',
      ),
    ];

    if (query == 'all') {
      return allVideos;
    }

    // Find videos with EXACT videoId match (case-sensitive)
    return allVideos.where((video) => video.videoId == query).toList();
  }
}
