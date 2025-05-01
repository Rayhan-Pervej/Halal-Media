import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/presentation/cubit/upload_video/upload_video_cubit.dart';
import 'package:halal_media/presentation/widgets/button/custom_rounded_text_button.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_dropdown_filed.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_input_field.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_multi_selection_dropdown.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_progress_indicator.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/tag_input_field.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/presentation/widgets/custom_appbar.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/video_picker.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppbar(
        isNavbar: false,
        title: "Upload Video",
        bottomBorder: true,
      ),
      body: BlocBuilder<UploadVideoCubit, UploadVideoState>(
        builder: (context, state) {
          if (state is UploadVideoLoading || state is UploadVideoInitial) {
            return const Center(child: CustomProgressIndicator());
          } else if (state is UploadVideoFormState) {
            final cubit = context.read<UploadVideoCubit>();
            return SingleChildScrollView(
              child: Column(
                children: [
                  AppDimension.h8,
                  VideoPicker(
                    controller: state.videoPlayerController,
                    videoFile: state.videoFile,
                    onPickVideo: cubit.pickVideo,
                    isMuted: state.isMuted,
                    isPlaying: state.isPlaying,
                    onTogglePlayPause: cubit.togglePlayPause,
                    onToggleMute: cubit.toggleMute,
                  ),
                  AppDimension.h16,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        CustomInputField(
                          label: 'Video Title',
                          controller: state.titleController,
                          maxLength: 150,
                        ),
                        CustomInputField(
                          label: 'Description',
                          isMultiline: true,
                          controller: state.descriptionController,
                          maxLength: 3200,
                        ),
                        CustomDropdownField(
                          showLabel: true,
                          labelText: "Category",
                          hintText: "Select a category",
                          showPrefixIcon: false,
                          iconSize: 0,
                          items: state.categories,
                          value: state.selectedCategory,
                          onChanged: cubit.setCategory,
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please select a category'
                                      : null,
                        ),
                        AppDimension.h16,
                        CustomMultiSelectDropdown(
                          hintText: 'add something',
                          items: state.videoTypes,
                          selectedItems: state.selectedTypes,
                          onSelectionChanged: cubit.setVideoTypes,
                          labelText: "Select the types of video",
                        ),
                        AppDimension.h16,
                        TagInputField(
                          tags: state.tags,
                          controller: state.tagController,
                          onAddTag: cubit.addTag,
                          onRemoveTag: cubit.removeTag,
                        ),
                        AppDimension.h16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Save as private button
                            CustomRoundedTextButton(
                              text: '',
                              onPressed:
                                  state.isUploading
                                      ? null
                                      : () => cubit.saveVideo(isPublic: false),
                              backgroundColor: AppColor.gray200,
                              textColor: AppColor.black900,
                              child:
                                  state.isUploading &&
                                          state.uploadingType ==
                                              UploadingType.private
                                      ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.black,
                                              ),
                                        ),
                                      )
                                      : customText(
                                        fontSize: 14,
                                        text: "Save as private",
                                        color: AppColor.black900,
                                        fontWeight: FontWeight.w500,
                                      ),
                            ),

                            // Save as public button
                            CustomRoundedTextButton(
                              text: '',
                              onPressed:
                                  state.isUploading
                                      ? null
                                      : () => cubit.saveVideo(isPublic: true),
                              backgroundColor: AppColor.green,
                              child:
                                  state.isUploading &&
                                          state.uploadingType ==
                                              UploadingType.public
                                      ? SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        ),
                                      )
                                      : customText(
                                        text: "Save as public",
                                        color: AppColor.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                            ),
                          ],
                        ),

                        // if (state.isUploading)
                        //   const Padding(
                        //     padding: EdgeInsets.all(12.0),
                        //     child: CustomProgressIndicator(),
                        //   ),
                        AppDimension.h16,
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
