import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/data/models/video_playlist_model.dart';
import 'package:halal_media/data/repositories/playlist_repo.dart';
import 'package:meta/meta.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  final PlaylistRepo playlistRepo;

  LibraryCubit(this.playlistRepo) : super(LibraryInitial());

  Future<void> fetchPlaylist(String userId) async {
    emit(LibraryLoading());
    try {
      final List<String> sortOptions = [
        'Recently Added',
        'Recently Played',
        'Recent activity',
        'A-Z',
        'Z-A',
      ];

      List<VideoPlaylistModel> playlists = await playlistRepo.fetchPlaylists();

      emit(LibraryLoaded(playlist: playlists, sortList: sortOptions));
    } catch (e) {
      emit(LibraryError(message: e.toString()));
    }
  }

  Future<void> createPlaylist(VideoPlaylistModel playlist) async {
    if (state is LibraryLoaded) {
      final currentState = state as LibraryLoaded;
      emit(currentState.copyWith(isPlaylistCreating: true));
      try {
        await playlistRepo.createPlaylist(playlist);
        await fetchPlaylist("userId");
      } catch (e) {
        emit(LibraryError(message: e.toString()));
      }
    }
  }

  Future<void> deletePlaylist(String id) async {
    if (state is LibraryLoaded) {
      final currentState = state as LibraryLoaded;
      emit(currentState.copyWith(isDeleteLoading: true));
      try {
        await playlistRepo.deletePlaylist(id);
        await fetchPlaylist("userId");
      } catch (e) {
        emit(LibraryError(message: e.toString()));
      }
    }
  }

  Future<void> editPlaylist(VideoPlaylistModel updatedPlaylist) async {
    if (state is LibraryLoaded) {
      final currentState = state as LibraryLoaded;
      emit(currentState.copyWith(isEditLoading: true));
      try {
        await playlistRepo.editPlaylist(updatedPlaylist);
        await fetchPlaylist("userId");
      } catch (e) {
        emit(LibraryError(message: e.toString()));
      }
    }
  }
}
