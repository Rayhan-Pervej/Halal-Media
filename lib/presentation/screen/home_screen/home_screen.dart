import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/data/repositories/video_repo.dart';
import 'package:halal_media/presentation/cubit/home/home_cubit.dart';
import 'package:halal_media/presentation/cubit/video_play/video_play_cubit.dart';
import 'package:halal_media/presentation/screen/video_play/video_play_screen.dart';
import 'package:halal_media/presentation/widgets/custom_appbar.dart';
import 'package:halal_media/presentation/widgets/large_thumbnail_card.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_progress_indicator.dart';
import 'package:halal_media/presentation/widgets/status_tab_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<HomeCubit>().videoLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scafoldBackground,
      appBar: CustomAppbar(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(child: CustomProgressIndicator());
          } else if (state is HomeError) {
            return Center(child: Text(state.message));
          } else if (state is HomeLoaded) {
            return ListView.builder(
              itemCount: state.videos.length + 1, // +1 for tab menu
              itemBuilder: (context, index) {
                if (index == 0) {
                  return StatusTabMenu(
                    tabs: state.categories,
                    initialTab: context.read<HomeCubit>().selectedTitle,
                    onTabSelected: (selected) {
                      context.read<HomeCubit>().onTabSelected(selected);
                    },
                  );
                }

                final video = state.videos[index - 1];
                final isLastItem = index == state.videos.length;

                return Column(
                  children: [
                    LargeThumbnailCard(
                      channelName: video.channelName,
                      thumbnail: video.thumbnail,
                      avatar: video.avatar,
                      title: video.title,
                      views: video.views,
                      date: video.date,
                      onFavorite: () {},
                      onShare: () {},
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => BlocProvider(
                                  create:
                                      (context) =>
                                          VideoPlayCubit( VideoRepo())
                                            ,
                                  child: VideoPlayScreen(id: video.videoId,),
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
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
