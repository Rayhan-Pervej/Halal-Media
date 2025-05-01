import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/data/models/video_model.dart';
import 'package:halal_media/data/repositories/video_repo.dart';
import 'package:meta/meta.dart';

part 'my_videos_state.dart';
class MyVideosCubit extends Cubit<MyVideosState> {
  final VideoRepo videoRepo;
  MyVideosCubit(this.videoRepo) : super(MyVideosInitial());

  Future<void> fetchVideos(String status) async {
    emit(MyVideosLoaded(videos: [], isVideoloading: true));
    try {
      final videos = await videoRepo.fetchVideosByStatus(status);
      emit(MyVideosLoaded(videos: videos, isVideoloading: false));
    } catch (e) {
      emit(MyVideosError());
    }
  }

  void toggleSelection(String id) {
    if (state is MyVideosLoaded) {
      final currentState = state as MyVideosLoaded;
      final currentSelection = Set<String>.from(currentState.selectedVideoIds);
      if (currentSelection.contains(id)) {
        currentSelection.remove(id);
      } else {
        currentSelection.add(id);
      }

      emit(currentState.copyWith(selectedVideoIds: currentSelection));
    }
  }

  void deleteSelectedVideos() {
    if (state is MyVideosLoaded) {
      final currentState = state as MyVideosLoaded;
      final updatedVideos = currentState.videos
          .where((v) => !currentState.selectedVideoIds.contains(v.videoId))
          .toList();

      emit(currentState.copyWith(
        videos: updatedVideos,
        selectedVideoIds: {},
      ));

      print("Deleted videos: ${currentState.selectedVideoIds}");
    }
  }
}
