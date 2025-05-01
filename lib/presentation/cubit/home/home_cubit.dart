import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/data/models/video_model.dart';
import 'package:halal_media/data/repositories/video_repo.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final VideoRepo repo;
  List<VideoModel> _allVideos = [];
  List<String> _categories = [];

  String selectedTitle = "All";

  HomeCubit(this.repo) : super(HomeInitial());

  Future<void> videoLoad() async {
    emit(HomeLoading());
    try {
      _allVideos = await repo.fetchVideos();
      _categories = _allVideos.map((video) => video.type).toSet().toList();

      emit(HomeLoaded(_filterVideos(selectedTitle), ["All", ..._categories]));
    } catch (e) {
      emit(HomeError("Failed to load videos"));
    }
  }

  void onTabSelected(String title) {
    selectedTitle = title;
    emit(HomeLoaded(_filterVideos(title), ["All", ..._categories]));
  }

  List<VideoModel> _filterVideos(String title) {
    if (title == "All") return _allVideos;
    return _allVideos.where((video) => video.type == title).toList();
  }
}
