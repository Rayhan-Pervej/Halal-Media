part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteLoaded extends FavoriteState {
  final List<VideoModel> videos;
  FavoriteLoaded(this.videos);
}

final class FavoriteError extends FavoriteState {
  final String message;
  FavoriteError(this.message);
}
