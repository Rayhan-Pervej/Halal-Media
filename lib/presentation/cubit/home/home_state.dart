part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class CategoryLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<VideoModel> videos;
   final List<String> categories;
  HomeLoaded(this.videos, this.categories);
}

final class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
