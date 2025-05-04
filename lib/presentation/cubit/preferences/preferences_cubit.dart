import 'package:bloc/bloc.dart';
import 'package:halal_media/data/repositories/profile_repo.dart';
import 'package:meta/meta.dart';

part 'preferences_state.dart';

class PreferencesCubit extends Cubit<PreferencesState> {
  final ProfileRepo profileRepo;

  PreferencesCubit(this.profileRepo) : super(PreferencesInitial());

  Future<void> loadPreferences() async {
    try {
      emit(PreferencesLoading());

      // Simulated list of all available topics (would come from API)
      final allTopics = [
        'quran',
        'hadith',
        'daily reminders',
        'seerah',
        'fiqh',
        'dua',
        'tafseer',

        'ramadan',
      ];

      // Fetch user profile (with preferences)
      final user = await profileRepo.fetchUserProfile();

      emit(
        PreferencesLoaded(
          allTopics: allTopics,
          selectedTopics: user.preferences,
        ),
      );
    } catch (e) {
      emit(PreferencesError("Failed to load preferences."));
    }
  }

  void updatePreferences(List<String> updatedSelectedTopics) {
    if (state is PreferencesLoaded) {
      final current = state as PreferencesLoaded;
      emit(
        PreferencesLoaded(
          allTopics: current.allTopics,
          selectedTopics: updatedSelectedTopics,
        ),
      );
    }
  }
}
