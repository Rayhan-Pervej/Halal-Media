import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/data/repositories/video_repo.dart';
import 'package:halal_media/presentation/cubit/favorite/favorite_cubit.dart';
import 'package:halal_media/presentation/cubit/video_play/video_play_cubit.dart';
import 'package:halal_media/presentation/screen/video_play/video_play_screen.dart';
import 'package:halal_media/presentation/widgets/custom_appbar.dart';
import 'package:halal_media/presentation/widgets/medium_thumbnail._card.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_progress_indicator.dart';

import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<FavoriteCubit>().fetchVideosByQuery('all');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scafoldBackground,
      appBar: CustomAppbar(
        isNavbar: false,
        bottomBorder: true,
        title: "Favorite",
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
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return Center(child: CustomProgressIndicator());
          } else if (state is FavoriteError) {
            return Center(child: customText(text: "Error", fontSize: 16));
          } else if (state is FavoriteLoaded) {
            if (state.videos.isEmpty) {
              return Center(child: Text("No videos found."));
            }
            return ListView.builder(
              itemCount: state.videos.length,
              itemBuilder: (context, index) {
                final video = state.videos[index];
                final isLastItem = index == state.videos.length;
                final isFirstItem = index == 0;
                return Column(
                  children: [
                    if (isFirstItem) AppDimension.h16,
                    MediumThumbnailCard(
                      channelName: video.channelName,
                      thumbnail: video.thumbnail,
                      avatar: video.avatar,
                      title: video.title,
                      views: video.views,
                      date: video.date,
                      isfavorite: video.isFavorite,
                      onFavorite: () {},
                      onShare: () {},
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => BlocProvider(
                                  create:
                                      (context) => VideoPlayCubit(VideoRepo()),
                                  child: VideoPlayScreen(id: video.videoId),
                                ),
                          ),
                        );
                      },
                    ),
                    if (!isLastItem) AppDimension.h16,
                  ],
                );
              },
            );
          } else if (state is FavoriteError) {
            return Center(child: Text("Something went wrong."));
          }

          return Center(child: Text("Search your favorite videos"));
        },
      ),
    );
  }
}
