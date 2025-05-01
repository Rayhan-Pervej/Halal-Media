import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/presentation/cubit/my_videos/my_videos_cubit.dart';
import 'package:halal_media/presentation/cubit/upload_video/upload_video_cubit.dart';
import 'package:halal_media/presentation/screen/upload_scren/upload_screen.dart';
import 'package:halal_media/presentation/widgets/custom_appbar.dart';
import 'package:halal_media/presentation/widgets/selectable_video_item.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_progress_indicator.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';
import 'package:halal_media/presentation/widgets/status_tab_Menu.dart';

class MyVideosScreen extends StatefulWidget {
  const MyVideosScreen({super.key});

  @override
  State<MyVideosScreen> createState() => _MyVideosScreenState();
}

class _MyVideosScreenState extends State<MyVideosScreen> {
  String selectedTitle = 'active';

  @override
  void initState() {
    super.initState();
    context.read<MyVideosCubit>().fetchVideos(selectedTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scafoldBackground,
      appBar: CustomAppbar(
        isNavbar: false,
        title: "My Videos",
        bottomBorder: true,
        appActionsBar: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColor.green,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => BlocProvider(
                        create: (context) => UploadVideoCubit()..init(),
                        child: const UploadScreen(),
                      ),
                ),
              );
            },
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/video_deep_green.png',
                  height: 24,
                  width: 24,
                ),
                AppDimension.w8,
                customText(text: "Upload", fontSize: 14, color: AppColor.white),
              ],
            ),
          ),
        ],
      ),
      body: BlocBuilder<MyVideosCubit, MyVideosState>(
        builder: (context, state) {
          if (state is MyVideosInitial || state is MyVideosLoading) {
            return const Center(child: CustomProgressIndicator());
          } else if (state is MyVideosLoaded) {
            final filteredItems =
                state.videos
                    .where((item) => item.status.toLowerCase() == selectedTitle)
                    .toList();
            final anySelected = state.selectedVideoIds.isNotEmpty;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: AppColor.white),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: StatusTabMenu(
                      tabs: [
                        'Active',
                        'Pending',
                        'Rejected',
                        'Drafts',
                        'Private',
                      ],
                      initialTab: 'Active',
                      onTabSelected: (selected) {
                        setState(() {
                          selectedTitle = selected.toLowerCase();
                        });
                        context.read<MyVideosCubit>().fetchVideos(
                          selectedTitle,
                        );
                      },
                    ),
                  ),
                ),
                Column(
                  children: [
                    AppDimension.h16,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        height: 36,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customText(
                              text:
                                  "${selectedTitle[0].toUpperCase()}${selectedTitle.substring(1)} Videos",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            if (anySelected)
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<MyVideosCubit>()
                                      .deleteSelectedVideos();
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: AppColor.green,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),

                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: AppColor.green,
                                      width: 1,
                                    ),

                                    borderRadius: BorderRadius.circular(360),
                                  ),
                                ),
                                child: customText(
                                  text: "Delete",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.white,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    AppDimension.h16,
                  ],
                ),
                state.isVideoloading
                    ? Expanded(
                      child: const Center(child: CustomProgressIndicator()),
                    )
                    : filteredItems.isEmpty
                    ? Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/no_video_found.png',
                              width: 150,
                              height: 150,
                            ),
                            const SizedBox(height: 16),
                            customText(
                              text: "No videos available in this tab.",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColor.black600,
                            ),
                          ],
                        ),
                      ),
                    )
                    : SingleChildScrollView(
                      child: Column(
                        children:
                            filteredItems.map((item) {
                              return SelectableVideoItem(
                                isSelected: state.selectedVideoIds.contains(
                                  item.videoId,
                                ),
                                onTap:
                                    () => context
                                        .read<MyVideosCubit>()
                                        .toggleSelection(item.videoId),
                                thumbnailPath: item.thumbnail,
                                title: item.title,
                                subtitle: item.title,
                                views: item.views,
                                favorites: item.views,
                                date: item.date,
                                status: item.status,
                                comments: item.views,
                                onPreview:
                                    () => print(
                                      "Preview tapped for ${item.title}",
                                    ),
                                onPrivate:
                                    () => print(
                                      "Private tapped for ${item.title}",
                                    ),
                                onEdit:
                                    () =>
                                        print("Edit tapped for ${item.title}"),
                                onShare:
                                    () =>
                                        print("Share tapped for ${item.title}"),
                                onDelete:
                                    () => print(
                                      "Delete tapped for ${item.title}",
                                    ),
                              );
                            }).toList(),
                      ),
                    ),
              ],
            );
          } else if (state is MyVideosError) {
            return const Center(child: Text("Something went wrong"));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
