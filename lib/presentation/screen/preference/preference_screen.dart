import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/presentation/widgets/button/selectable_button.dart';
import 'package:halal_media/presentation/widgets/custom_appbar.dart';
import 'package:halal_media/data/repositories/profile_repo.dart';
import 'package:halal_media/presentation/cubit/preferences/preferences_cubit.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_progress_indicator.dart';

class PreferenceScreen extends StatelessWidget {
  const PreferenceScreen({super.key});

  void toggleSelection(
    BuildContext context,
    String topic,
    List<String> selectedTopics,
  ) {
    final updated = List<String>.from(selectedTopics);
    if (updated.contains(topic)) {
      updated.remove(topic);
    } else {
      updated.add(topic);
    }
    context.read<PreferencesCubit>().updatePreferences(updated);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PreferencesCubit(ProfileRepo())..loadPreferences(),
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: CustomAppbar(
          isNavbar: false,
          title: "Preferences",
          bottomBorder: true,
          appActionsBar: [
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/icons/search_black.png',
                height: 20,
                width: 20,
              ),
            ),
          ],
        ),
        body: BlocBuilder<PreferencesCubit, PreferencesState>(
          builder: (context, state) {
            if (state is PreferencesLoading) {
              return const Center(child: CustomProgressIndicator());
            } else if (state is PreferencesLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children:
                      state.allTopics.map((topic) {
                        final isSelected = state.selectedTopics.contains(topic);
                        final icon =
                            topic == "quran"
                                ? "quran"
                                : "book"; // simple mapping

                        return Column(
                          children: [
                            SelectableButton(
                              text:
                                  topic[0].toUpperCase() +
                                  topic.substring(1), // Capitalize
                              assetIcon: icon,
                              isSelected: isSelected,
                              onTap:
                                  () => toggleSelection(
                                    context,
                                    topic,
                                    state.selectedTopics,
                                  ),
                            ),
                            AppDimension.h10,
                          ],
                        );
                      }).toList(),
                ),
              );
            } else if (state is PreferencesError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
