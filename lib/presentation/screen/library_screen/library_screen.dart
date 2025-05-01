import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/presentation/cubit/library/library_cubit.dart';
import 'package:halal_media/presentation/widgets/button/custom_dropdown.dart';
import 'package:halal_media/presentation/widgets/button/custom_rounded_text_button.dart';
import 'package:halal_media/presentation/widgets/button/video_playlist_button.dart';

import 'package:halal_media/presentation/widgets/custom_appbar.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_progress_indicator.dart';

import '../../../data/models/video_playlist_model.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppbar(bottomBorder: true),
      body: BlocBuilder<LibraryCubit, LibraryState>(
        builder: (context, state) {
          if (state is LibraryLoading) {
            return const Center(child: CustomProgressIndicator());
          }
          if (state is LibraryLoaded) {
            final sortOptions = state.sortList;
            final playlist = state.playlist;
            String? selectedValue;

            if (sortOptions.isNotEmpty) {
              selectedValue = sortOptions.first;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                if (selectedValue != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomDropdown(
                      selectedValue: selectedValue,
                      items: sortOptions,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedValue = value;
                          });
                        }
                      },
                    ),
                  ),

                AppDimension.h16,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(
                      children:
                          playlist.isNotEmpty
                              ? playlist.map((p) {
                                return Column(
                                  children: [
                                    VideoPlaylistButton(
                                      title: p.title,
                                      privacy: p.privacy,
                                      thumbnail1: p.thumbnail2,
                                      thumbnail2: p.thumbnail1,
                                      thumbnail3: p.thumbnail2,
                                      onTap: () {},
                                      onDelete: () {
                                        context
                                            .read<LibraryCubit>()
                                            .deletePlaylist(p.id);
                                      },
                                      onEdit: () {
                                        final updated = p.copyWith(
                                          title: "${p.title} (Edited)",
                                        );
                                        context
                                            .read<LibraryCubit>()
                                            .editPlaylist(updated);
                                      },
                                    ),
                                    AppDimension.h16,
                                  ],
                                );
                              }).toList()
                              : [Center(child: Text("No Playlists Available"))],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is LibraryError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const SizedBox();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomRoundedTextButton(
        style: TextButton.styleFrom(
          backgroundColor: AppColor.green,
          foregroundColor: AppColor.black900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(360),
            side: BorderSide(color: AppColor.gray200),
          ),
        ),
        text: "Create New Playlist",
        onPressed: () {
          final newPlaylist = VideoPlaylistModel(
            id: DateTime.now().toString(), // Unique ID or generated by backend
            title: "New Playlist",
            privacy: "Public",
            videos: [],
          );
          context.read<LibraryCubit>().createPlaylist(newPlaylist);
        },
      ),
    );
  }
}
