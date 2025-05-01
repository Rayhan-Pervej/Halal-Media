import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';

class ThreeDotButton extends StatelessWidget {
  final VoidCallback onShare;
  final String assetFavoriteIcon;
  final VoidCallback onFavorite;
  final Color? backgroundColor;
  const ThreeDotButton({
    super.key,
    required this.onShare,
    required this.onFavorite,
    this.backgroundColor,
    required this.assetFavoriteIcon,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      iconColor: AppColor.deepGreen,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          backgroundColor ?? Colors.transparent,
        ),
      ),

      offset: const Offset(0, 40), // Show popup below the icon
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: AppColor.white,
      onSelected: (value) {
        if (value == 'share') {
          onShare();
        } else if (value == 'favorite') {
          onFavorite();
        }
      },
      itemBuilder:
          (context) => [
            PopupMenuItem(
              value: 'share',
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/share_video_black.png',
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 8),
                  Text('Share'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'favorite',
              child: Row(
                children: [
                  Image.asset(
                   assetFavoriteIcon,
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 8),
                  Text('Favorite'),
                ],
              ),
            ),
          ],
    );
  }
}
