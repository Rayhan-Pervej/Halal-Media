import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';

import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class SettingsMenu extends StatelessWidget {
  final VoidCallback myVideoTap;
  final VoidCallback myChannelTap;
  final VoidCallback notesTap;
  final VoidCallback favoriteTap;
  final VoidCallback earningTap;
  final VoidCallback historyTap;
  final VoidCallback preferencesTap;
  final VoidCallback ratingTap;
  final VoidCallback settingsTap;
  final VoidCallback shareTap;
  final VoidCallback logoutTap;

  const SettingsMenu({
    super.key,

    required this.myChannelTap,
    required this.notesTap,
    required this.myVideoTap,
    required this.favoriteTap,
    required this.earningTap,
    required this.historyTap,
    required this.preferencesTap,
    required this.settingsTap,
    required this.ratingTap,
    required this.shareTap,
    required this.logoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),

      child: Column(
        children: [
          _iconTextButton(
            assetIcon: 'assets/icons/my_channel_black.png',
            label: "My Profile",
            onTap: myChannelTap,
          ),

          AppDimension.h8,
          _iconTextButton(
            assetIcon: 'assets/icons/my_video_black.png',
            label: "My Videos",
            onTap: myVideoTap,
          ),
          AppDimension.h8,
          _iconTextButton(
            assetIcon: 'assets/icons/favorite_black.png',
            label: "Favorite",
            onTap: favoriteTap,
          ),
          AppDimension.h8,
          _iconTextButton(
            assetIcon: 'assets/icons/note_black.png',
            label: "Notes",
            onTap: notesTap,
          ),
          AppDimension.h8,
          _iconTextButton(
            assetIcon: 'assets/icons/history_black.png',
            label: "History",
            onTap: historyTap,
          ),
          AppDimension.h8,
          _iconTextButton(
            assetIcon: 'assets/icons/preference_black.png',
            label: "Preferences",
            onTap: preferencesTap,
          ),
          AppDimension.h8,
          _iconTextButton(
            assetIcon: 'assets/icons/share_video_black.png',
            label: "Rating",
            onTap: settingsTap,
          ),
          AppDimension.h8,
          _iconTextButton(
            assetIcon: 'assets/icons/earning_black.png',
            label: "Earning",
            onTap: earningTap,
          ),

          AppDimension.h8,
          _iconTextButton(
            assetIcon: 'assets/icons/setting_black.png',
            label: "Settings",
            onTap: settingsTap,
          ),
          AppDimension.h8,
          _iconTextButton(
            assetIcon: 'assets/icons/share_video_black.png',
            label: "Share App",
            onTap: shareTap,
          ),
          AppDimension.h8,
          _iconTextButton(
            assetIcon: 'assets/icons/logout_black.png',
            label: "Logout",
            onTap: logoutTap,
          ),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
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
            Image.asset(
              'assets/icons/arrow_right_black.png',
              height: 20,
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
