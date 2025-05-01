part of 'notes_cubit.dart';

@immutable
sealed class NotesState {}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<VideoModel> notes;
  final Map<String, bool> editInProgress;
  final Map<String, bool> deleteInProgress;
  final Map<String, bool> shareInProgress;
  final Map<String, bool> viewInProgress;

  NotesLoaded({
    required this.notes,
    this.editInProgress = const {},
    this.deleteInProgress = const {},
    this.shareInProgress = const {},
    this.viewInProgress = const {},
  });

  NotesLoaded copyWith({
    List<VideoModel>? notes,
    Map<String, bool>? editInProgress,
    Map<String, bool>? deleteInProgress,
    Map<String, bool>? shareInProgress,
    Map<String, bool>? viewInProgress,
  }) {
    return NotesLoaded(
      notes: notes ?? this.notes,
      editInProgress: editInProgress ?? this.editInProgress,
      deleteInProgress: deleteInProgress ?? this.deleteInProgress,
      shareInProgress: shareInProgress ?? this.shareInProgress,
      viewInProgress: viewInProgress ?? this.viewInProgress,
    );
  }
}

class NotesError extends NotesState {
  final String message;
  NotesError(this.message);
}

