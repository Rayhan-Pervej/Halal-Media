import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/data/models/video_model.dart';
import 'package:halal_media/data/repositories/video_repo.dart';
import 'package:meta/meta.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final VideoRepo videoRepo;
  NotesCubit(this.videoRepo) : super(NotesInitial());

  Future<void> fetchNotes(String videoId) async {
    emit(NotesLoading());
    try {
      final notes = await videoRepo.fetchNotesByVideoId(videoId);
      emit(NotesLoaded(notes: notes));
    } catch (e) {
      emit(NotesError("Failed to load notes"));
    }
  }

  void _updateActionStatus({
    required String videoId,
    required String action,
    required bool inProgress,
  }) {
    if (state is! NotesLoaded) return;

    final current = state as NotesLoaded;

    switch (action) {
      case 'edit':
        emit(
          current.copyWith(
            editInProgress: {...current.editInProgress, videoId: inProgress},
          ),
        );
        break;
      case 'delete':
        emit(
          current.copyWith(
            deleteInProgress: {
              ...current.deleteInProgress,
              videoId: inProgress,
            },
          ),
        );
        break;
      case 'share':
        emit(
          current.copyWith(
            shareInProgress: {...current.shareInProgress, videoId: inProgress},
          ),
        );
        break;
      case 'view':
        emit(
          current.copyWith(
            viewInProgress: {...current.viewInProgress, videoId: inProgress},
          ),
        );
        break;
    }
  }

  // Button triggers
  void onEditTapped(String videoId) async {
    _updateActionStatus(videoId: videoId, action: 'edit', inProgress: true);
    await Future.delayed(Duration(seconds: 3));
    _updateActionStatus(videoId: videoId, action: 'edit', inProgress: false);
  }

  void onDeleteTapped(String videoId) async {
    _updateActionStatus(videoId: videoId, action: 'delete', inProgress: true);
    await Future.delayed(Duration(seconds: 3));
    _updateActionStatus(videoId: videoId, action: 'delete', inProgress: false);
  }

  void onShareTapped(String videoId) async {
    _updateActionStatus(videoId: videoId, action: 'share', inProgress: true);
    await Future.delayed(Duration(seconds: 3));
    _updateActionStatus(videoId: videoId, action: 'share', inProgress: false);
  }

  void onViewTapped(String videoId) async {
    _updateActionStatus(videoId: videoId, action: 'view', inProgress: true);
    await Future.delayed(Duration(seconds: 3));
    _updateActionStatus(videoId: videoId, action: 'view', inProgress: false);
  }
}
