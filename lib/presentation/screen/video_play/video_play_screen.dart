import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';

import 'package:halal_media/presentation/cubit/video_play/video_play_cubit.dart';

import 'package:halal_media/presentation/widgets/large_thumbnail_card.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_progress_indicator.dart';

import 'package:halal_media/presentation/widgets/shared_widgets/growable_editor.dart';
import 'package:halal_media/presentation/widgets/video_detail_section.dart';
import 'package:halal_media/presentation/widgets/video_player_card.dart';

class VideoPlayScreen extends StatefulWidget {
  final String id;
  const VideoPlayScreen({super.key, required this.id});

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  @override
  void initState() {
    super.initState();
    context.read<VideoPlayCubit>().fetchVideoById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scafoldBackground,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<VideoPlayCubit, VideoPlayState>(
          builder: (context, state) {
            if (state is VideoPlayLoading) {
              return const Center(child: CustomProgressIndicator());
            } else if (state is VideoPlayLoaded) {
              final video = state.videos;

              return ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  Container(
                    color: AppColor.deepGreen,
                    child: VideoPlayerCard(videoUrl: video.videoUrl),
                  ),
                  VideoDetailSection(
                    title: video.title,
                    metaText: "${video.views} • ${video.date}",
                    channelName: "Voice of Books",
                    subscriberCount: "289K subscribe",
                    isSubscribed: state.isSubscribed,
                    isSubcribeLoading: state.isSubscribeLoading,
                    isFavorite: state.isFavorite,
                    isDescriptionSelected: state.isDescriptionSelected,
                    description: video.description,
                    onToggleSubscribe:
                        () => context.read<VideoPlayCubit>().toggleSubscribe(),
                    onToggleFavorite:
                        () => context.read<VideoPlayCubit>().toggleFavorite(),
                    onShare: () => context.read<VideoPlayCubit>().shareVideo(),
                    onToggleDescription:
                        () =>
                            context
                                .read<VideoPlayCubit>()
                                .toggleIsDescription(),
                    onShowMore: () {},
                    noteEditor: GrowableQuillBox(
                      controller: context.read<VideoPlayCubit>().controller,
                      onAdd: () {},
                      onRemove: () {},
                    ),
                  ),
                  AppDimension.h16,
                  LargeThumbnailCard(
                    channelName: 'Learn Al Quran',
                    thumbnail: "assets/thumbnails/thumbnail_1.png",
                    avatar: "assets/icons/avatar_1.png",
                    title:
                        "Bulbuli | Coke Studio Bangla | Season One | Ritu Raj X Nandita",
                    views: "1.5M",
                    date: "2 days ago",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VideoPlayScreen(id: "2"),
                        ),
                      );
                    },
                    onFavorite: () {},
                    onShare: () {},
                  ),
                  AppDimension.h16,
                  LargeThumbnailCard(
                    channelName: 'Learn Al Quran',
                    thumbnail: "assets/thumbnails/thumbnail_1.png",
                    avatar: "assets/icons/avatar_1.png",
                    title:
                        "Bulbuli | Coke Studio Bangla | Season One | Ritu Raj X Nandita",
                    views: "1.5M",
                    date: "2 days ago",
                    onTap: () {},
                    onFavorite: () {},
                    onShare: () {},
                  ),
                ],
              );
            } else if (state is VideoPlayError) {
              return Center(child: Text("Error: ${state.message}"));
            }

            return const SizedBox(); // Default fallback
          },
        ),
      ),
    );
  }
}









 // Padding(
                //         padding: const EdgeInsets.all(12),
                //         child: Column(
                //           children: [
                //             Row(
                //               mainAxisAlignment:
                //                   MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Row(
                //                   children: [
                //                     customText(
                //                       text: "Comments",
                //                       fontSize: 12,
                //                       fontWeight: FontWeight.w400,
                //                     ),
                //                     AppDimension.w2,
                //                     customText(
                //                       text: "149",
                //                       fontSize: 12,
                //                       color: AppColor.black600,
                //                       fontWeight: FontWeight.w400,
                //                     ),
                //                   ],
                //                 ),
                //               ],
                //             ),
                //             AppDimension.h12,
                //             Row(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Expanded(
                //                   child: customText(
                //                     color: AppColor.black900,
                //                     text:
                //                         "জাযাকাল্লাহ ভাইয়া আপনার এই মেহনত আল্লাহ কবুল করুক সম্ভব হলে প্রতিদিন ১টা করে porbo দিয়েন",
                //                     fontSize: 12,
                //                     lineHeight: 0,
                //                     fontWeight: FontWeight.w400,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //             AppDimension.w8,
                //           ],
                //         ),
                //       ),