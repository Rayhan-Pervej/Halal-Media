import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/data/repositories/profile_repo.dart';
import 'package:halal_media/data/repositories/video_repo.dart';
import 'package:halal_media/presentation/cubit/favorite/favorite_cubit.dart';
import 'package:halal_media/presentation/cubit/history/history_cubit.dart';
import 'package:halal_media/presentation/cubit/more/more_cubit.dart';
import 'package:halal_media/presentation/cubit/my_profile/my_profile_cubit.dart';
import 'package:halal_media/presentation/cubit/my_videos/my_videos_cubit.dart';
import 'package:halal_media/presentation/cubit/notes/notes_cubit.dart';
import 'package:halal_media/presentation/cubit/preferences/preferences_cubit.dart';
import 'package:halal_media/presentation/screen/favorite_screen/favorite_screen.dart';
import 'package:halal_media/presentation/screen/history_screen/history_screen.dart';
import 'package:halal_media/presentation/screen/my_profile_screen/my_profile_screen.dart';
import 'package:halal_media/presentation/screen/my_videos_screen/my_videos_screen.dart';
import 'package:halal_media/presentation/screen/notes_screen/notes_screen.dart';
import 'package:halal_media/presentation/screen/preference/preference_screen.dart';
import 'package:halal_media/presentation/widgets/custom_appbar.dart';
import 'package:halal_media/presentation/widgets/settings_menu.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scafoldBackground,
      appBar: CustomAppbar(),
      body: ListView(
        children: [
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

          //   child: Row(
          //     children: [
          //       SizedBox(
          //         height: 36,
          //         width: 36,
          //         child: CircleAvatar(
          //           backgroundImage: AssetImage('assets/icons/avatar_1.png'),
          //         ),
          //       ),
          //       AppDimension.w10,
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           customText(
          //             text: "Rayhan Pervej",
          //             fontSize: 14,
          //             fontWeight: FontWeight.w700,
          //           ),
          //           AppDimension.h2,
          //           customText(
          //             text: "2.1M Subscriber",
          //             fontSize: 14,
          //             fontWeight: FontWeight.w400,
          //             color: AppColor.black600,
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          AppDimension.h8,
          BlocBuilder<MoreCubit, MoreState>(
            builder: (context, state) {
              return SettingsMenu(
                myChannelTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BlocProvider(
                            create: (context) => MyProfileCubit(ProfileRepo()),
                            child: MyProfileScreen(),
                          ),
                    ),
                  );
                },

                myVideoTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BlocProvider(
                            create: (context) => MyVideosCubit(VideoRepo()),
                            child: MyVideosScreen(),
                          ),
                    ),
                  );
                },
                notesTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BlocProvider(
                            create:
                                (_) =>
                                    NotesCubit(VideoRepo())..fetchNotes('all'),
                            child: NotesScreen(),
                          ),
                    ),
                  );
                },
                favoriteTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BlocProvider(
                            create:
                                (_) =>
                                    FavoriteCubit(VideoRepo())
                                      ..fetchVideosByQuery("all"),
                            child: const FavoriteScreen(),
                          ),
                    ),
                  );
                },
                earningTap: () {},
                historyTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BlocProvider(
                            create: (_) => HistoryCubit(VideoRepo()),
                            child: HistoryScreen(),
                          ),
                    ),
                  );
                },
                preferencesTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BlocProvider(
                            create:
                                (context) =>
                                    PreferencesCubit(ProfileRepo())
                                      ..loadPreferences(),
                            child: PreferenceScreen(),
                          ),
                    ),
                  );
                },

                settingsTap: () {},
                logoutTap: () {
                  // Handle the logout action
                  context.read<MoreCubit>().getSharelink();
                },
                ratingTap: () {},
                shareTap: () {
                  // Trigger the share action based on the state
                  context.read<MoreCubit>().getSharelink();
                },
              );
            },
          ),

          AppDimension.h8,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _iconTextButton(
                assetIcon: 'assets/icons/logout_black.png',
                label: "Delete Account",
                onTap: () {},
              ),
            ],
          ),
          AppDimension.h10,
        ],
      ),
    );
  }

  Widget _iconTextButton({
    required String assetIcon,
    required String label,

    required VoidCallback onTap,
  }) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor: AppColor.white,
        //iconColor: MyColor.black,
        //overlayColor: MyColor.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(assetIcon, height: 24, width: 24),
            SizedBox(width: 16),
            customText(
              color: AppColor.black900,
              text: label,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
