import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:halal_media/data/models/video_model.dart';
import 'package:halal_media/data/repositories/video_repo.dart';
import 'package:meta/meta.dart';
import 'package:share_plus/share_plus.dart';

part 'video_play_state.dart';

class VideoPlayCubit extends Cubit<VideoPlayState> {
  QuillController controller;
  final VideoRepo _videoRepo;

  VideoPlayCubit(this._videoRepo)
    : controller = QuillController.basic(),
      super(VideoPlayInitial());

  Future<void> fetchVideoById(String id) async {
    try {
      emit(VideoPlayLoading());

      List<VideoModel> videoList = await _videoRepo.fetchVideosByQuery(id);

      if (videoList.isNotEmpty) {
        final videoData = videoList.first;

        bool alreadySubscribed = videoData.isSubscribed; // fallback if needed

        emit(
          VideoPlayLoaded(
            videos: videoData,
            isSubscribed: alreadySubscribed,
            isFavorite: videoData.isFavorite,
          ),
        );
      } else {
        emit(VideoPlayError('No video found for the given ID'));
      }
    } catch (e) {
      print(e.toString());
      emit(VideoPlayError('Failed to load video: $e'));
    }
  }

  Future<void> toggleSubscribe() async {
    if (state is VideoPlayLoaded) {
      final currentState = state as VideoPlayLoaded;

      // Set loading true
      emit(currentState.copyWith(isSubscribeLoading: true));

      await Future.delayed(Duration(seconds: 2)); // simulate API call

      // Toggle based on current isSubscribed
      emit(
        currentState.copyWith(
          isSubscribeLoading: false,
          isSubscribed: !currentState.isSubscribed, // <--- FLIP the bool
        ),
      );
    }
  }

  void toggleIsDescription() {
    if (state is VideoPlayLoaded) {
      final currentState = state as VideoPlayLoaded;
      emit(
        currentState.copyWith(
          isDescriptionSelected: !currentState.isDescriptionSelected,
        ),
      );
    }
  }

  Future<void> shareVideo() async {
    if (state is VideoPlayLoaded) {
      final currentState = state as VideoPlayLoaded;
      final String videoId = currentState.videos.videoUrl; 

      final String fullShareUrl = videoId;

      await SharePlus.instance.share(ShareParams(uri: Uri.parse(fullShareUrl)));
    }
  }

  void toggleFavorite() {
    if (state is VideoPlayLoaded) {
      final currentState = state as VideoPlayLoaded;
      emit(currentState.copyWith(isFavorite: !currentState.isFavorite));
    }
  }
}
