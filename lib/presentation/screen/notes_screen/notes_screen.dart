import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/data/models/video_model.dart';
import 'package:halal_media/data/repositories/video_repo.dart';
import 'package:halal_media/presentation/cubit/notes/notes_cubit.dart';
import 'package:halal_media/presentation/cubit/video_play/video_play_cubit.dart';
import 'package:halal_media/presentation/screen/video_play/video_play_screen.dart';
import 'package:halal_media/presentation/widgets/button/custom_rounded_text_button.dart';
import 'package:halal_media/presentation/widgets/button/custom_text_button.dart';
import 'package:halal_media/presentation/widgets/custom_appbar.dart';
import 'package:halal_media/presentation/widgets/custom_divider.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scafoldBackground,
      appBar: CustomAppbar(
        isNavbar: false,
        title: 'Notes',
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
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          if (state is NotesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NotesError) {
            return Center(child: Text(state.message));
          }

          if (state is NotesLoaded) {
            final notes = state.notes;

            return ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: _noteCard(context: context, note: note, state: state),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _customButton({
    required Widget child,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 36,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }

  Widget _noteCard({
    required BuildContext context,
    required VideoModel note,
    required NotesLoaded state,
  }) {
    final cubit = context.read<NotesCubit>();
    final isEditing = state.editInProgress[note.videoId] ?? false;
    final isDeleting = state.deleteInProgress[note.videoId] ?? false;
    final isSharing = state.shareInProgress[note.videoId] ?? false;
    final isViewing = state.viewInProgress[note.videoId] ?? false;

    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      note.avatar,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                    AppDimension.w8,
                    Expanded(
                      child: CustomTextButton(
                        decoration: TextDecoration.underline,
                        ontap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => BlocProvider(
                                    create:
                                        (context) =>
                                            VideoPlayCubit(VideoRepo()),
                                    child: VideoPlayScreen(id: note.videoId),
                                  ),
                            ),
                          );
                        },
                        text: note.title,
                        color: AppColor.black900,
                      ),
                    ),
                  ],
                ),
                AppDimension.h16,
                customText(
                  text: note.notes!,
                  color: AppColor.black600,
                  fontSize: 14,
                ),
              ],
            ),
          ),
          CustomDivider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left buttons
                Row(
                  children: [
                    isEditing
                        ? SizedBox(
                          width: 24,
                          height: 24,
                          child: LoadingAnimationWidget.waveDots(
                            color: AppColor.green,
                            size: 24,
                          ),
                        )
                        : _customButton(
                          onPressed: () => cubit.onEditTapped(note.videoId),
                          child: Image.asset(
                            "assets/icons/edit_white.png",
                            height: 24,
                            width: 24,
                          ),
                        ),
                    AppDimension.w6,
                    isDeleting
                        ? SizedBox(
                          width: 24,
                          height: 24,
                          child: LoadingAnimationWidget.waveDots(
                            color: AppColor.green,
                            size: 24,
                          ),
                        )
                        : _customButton(
                          onPressed: () => cubit.onDeleteTapped(note.videoId),
                          child: Image.asset(
                            "assets/icons/trash_white.png",
                            height: 24,
                            width: 24,
                          ),
                        ),
                    AppDimension.w6,
                    isSharing
                        ? SizedBox(
                          width: 24,
                          height: 24,
                          child: LoadingAnimationWidget.waveDots(
                            color: AppColor.green,
                            size: 24,
                          ),
                        )
                        : _customButton(
                          onPressed: () => cubit.onShareTapped(note.videoId),
                          child: Image.asset(
                            "assets/icons/share_white.png",
                            height: 24,
                            width: 24,
                          ),
                        ),
                  ],
                ),
                // Right side
                Row(
                  children: [
                    customText(
                      text: note.watchDate,
                      fontSize: 14,
                      color: AppColor.black600,
                    ),
                    AppDimension.w18,
                    isViewing
                        ? SizedBox(
                          height: 28,
                          width: 28,
                          child: LoadingAnimationWidget.waveDots(
                            color: AppColor.green,
                            size: 24,
                          ),
                        )
                        : CustomRoundedTextButton(
                          text: "View",
                          textColor: AppColor.black900,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 18,
                            ),
                            backgroundColor: AppColor.gray200,
                          ),
                          onPressed: () => cubit.onViewTapped(note.videoId),
                        ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
