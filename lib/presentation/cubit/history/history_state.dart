part of 'history_cubit.dart';

@immutable
sealed class HistoryState {}

final class HistoryInitial extends HistoryState {}


final class HistoryLoaded extends HistoryState {
  final List<VideoModel> videos;
  final String selectedFilter;
  final DateTime? selectedDate;
  final bool isVideolistLoading;

  HistoryLoaded({
    required this.videos,
    required this.selectedFilter,
    this.selectedDate,
    this.isVideolistLoading = false,
  });

  HistoryLoaded copyWith({
    List<VideoModel>? videos,
    String? selectedFilter,
    DateTime? selectedDate,
    bool? isVideolistLoading,
  }) {
    return HistoryLoaded(
      videos: videos ?? this.videos,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      selectedDate: selectedDate ?? this.selectedDate,
      isVideolistLoading: isVideolistLoading ?? this.isVideolistLoading,
    );
  }
}

final class HistoryError extends HistoryState{}
