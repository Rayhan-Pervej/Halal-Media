import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/data/models/video_model.dart';
import 'package:halal_media/data/repositories/video_repo.dart';
import 'package:meta/meta.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final VideoRepo videoRepo;
  HistoryCubit(this.videoRepo) : super(HistoryInitial());

  Future<void> fetchHistory(String filter, {DateTime? date}) async {
    emit(
      HistoryLoaded(
        videos: [],
        selectedFilter: filter,
        selectedDate: date,
        isVideolistLoading: true,
      ),
    );

    try {
      String query;

      switch (filter) {
        case 'Today':
          query = _formatDate(DateTime.now());
          break;
        case 'Yesterday':
          query = _formatDate(DateTime.now().subtract(Duration(days: 1)));
          break;
        case 'This Week':
          query = 'all'; // Adjust this based on your repo logic
          break;
        case 'This Month':
          query = _monthMatchQuery(DateTime.now());
          break;
        case 'Last Month':
          final now = DateTime.now();
          final lastMonth = DateTime(now.year, now.month - 1, 1);
          query = _monthMatchQuery(lastMonth);
          break;
        case 'Custom':
          query = _formatDate(date!);
          break;
        default:
          query = 'all';
      }

      final videos = await videoRepo.fetchVideosByDate(query);

      emit(
        HistoryLoaded(
          videos: videos,
          selectedFilter: filter,
          selectedDate: date,
          isVideolistLoading: false,
        ),
      );
    } catch (e) {
      emit(HistoryError());
    }
  }

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

  String _monthMatchQuery(DateTime date) {
    return 'all'; // Customize this if month-based filtering is supported
  }
}
