import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/data/models/video_model.dart';
import 'package:halal_media/data/repositories/video_repo.dart';
import 'package:meta/meta.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final VideoRepo repo;
  Timer? _debounce;
  FavoriteCubit(this.repo) : super(FavoriteInitial());
  void search(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(Duration(seconds: 2), () {
      if (query.isEmpty) {
        emit(FavoriteInitial());
      } else {
        fetchVideosByQuery(query);
      }
    });
  }

  Future<void> fetchVideosByQuery(String query) async {
    try {
      emit(FavoriteLoading());
      final videos = await repo.fetchVideosByQuery(query);
      emit(FavoriteLoaded(videos));
    } catch (e) {
      emit(FavoriteError(" Video not found or can't load"));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
