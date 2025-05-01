part of 'preferences_cubit.dart';

@immutable
sealed class PreferencesState {}

final class PreferencesInitial extends PreferencesState {}

final class PreferencesLoading extends PreferencesState {}

final class PreferencesLoaded extends PreferencesState {
  final List<String> allTopics;
  final List<String> selectedTopics;

  PreferencesLoaded({
    required this.allTopics,
    required this.selectedTopics,
  });
}

final class PreferencesError extends PreferencesState {
  final String message;

  PreferencesError(this.message);
}
