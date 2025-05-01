import 'package:halal_media/data/models/video_playlist_model.dart';
import 'video_repo.dart';

class PlaylistRepo {
  final VideoRepo _videoRepo = VideoRepo();

  // Simulated playlist list
  final List<VideoPlaylistModel> _playlists = [];

  Future<List<VideoPlaylistModel>> fetchPlaylists() async {
    if (_playlists.isEmpty) {
      final allVideos = await _videoRepo.fetchVideos();
      final playlist1Videos = allVideos.where((v) => ['1', '2'].contains(v.videoId)).toList();
      final playlist2Videos = allVideos.where((v) => ['2', '3'].contains(v.videoId)).toList();

      _playlists.addAll([
        VideoPlaylistModel(
          id: 'p1',
          title: 'Liked Videos',
          privacy: 'private',
          videos: playlist1Videos,         
        ),
        VideoPlaylistModel(
          id: 'p2',
          title: 'My Collection',
          privacy: 'public',
          videos: playlist2Videos,
        ),
      ]);
    }

    return Future.value(_playlists);
  }

  // ✅ Create Playlist
  Future<void> createPlaylist(VideoPlaylistModel playlist) async {
    _playlists.add(playlist);
    return Future.value();
  }

  // ✅ Delete Playlist
  Future<void> deletePlaylist(String id) async {
    _playlists.removeWhere((playlist) => playlist.id == id);
    return Future.value();
  }

  // ✅ Edit Playlist
  Future<void> editPlaylist(VideoPlaylistModel updated) async {
    final index = _playlists.indexWhere((p) => p.id == updated.id);
    if (index != -1) {
      _playlists[index] = updated;
    }
    return Future.value();
  }
}
