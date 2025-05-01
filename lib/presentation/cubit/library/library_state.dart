part of 'library_cubit.dart';

@immutable
sealed class LibraryState {}

final class LibraryInitial extends LibraryState {}

final class LibraryInital extends LibraryState {}
final class LibraryLoading extends LibraryState{}
final class LibraryLoaded extends LibraryState {
  final List<VideoPlaylistModel> playlist;
  final List<String> sortList;
  final bool isPlaylistLoading;
  final bool isPlaylistCreating;
  final bool isDeleteLoading;
  final bool isDeleted;
  final bool isEditLoading;
  final bool isEditd;

  LibraryLoaded({
    required this.playlist,
    required this.sortList,
    this.isPlaylistLoading = false,
    this.isPlaylistCreating = false,
    this.isDeleteLoading = false,
    this.isDeleted = false,
    this.isEditLoading = false,
    this.isEditd = false,
  });

  LibraryLoaded copyWith({
    List<VideoPlaylistModel>? playlist,
    List<String>? sortList,
    bool? isPlaylistLoading,
    bool? isPlaylistCreating,
    bool? isDeleteLoading,
    bool? isDeleted,
    bool? isEditLoading,
    bool? isEditd,
  }) {
    return LibraryLoaded(
      isPlaylistLoading: isPlaylistLoading ?? this.isPlaylistLoading,
      sortList: sortList ?? this.sortList,
      playlist: playlist ?? this.playlist,
      isPlaylistCreating: isPlaylistCreating ?? this.isPlaylistCreating,
      isDeleteLoading: isDeleteLoading ?? this.isDeleteLoading,
      isDeleted: isDeleted ?? this.isDeleted,
      isEditLoading: isEditLoading ?? this.isEditLoading,
      isEditd: isEditd ?? this.isEditd,
    );
  }
}

final class LibraryError extends LibraryState {
  final String message;
  LibraryError({required this.message});
}
