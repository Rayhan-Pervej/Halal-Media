import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/presentation/widgets/button/three_dot_button.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class MediumThumbnailCard extends StatelessWidget {
  final String thumbnail;
  final String avatar;
  final String channelName;
  final String title;
  final String views;
  final String date;
  final VoidCallback onTap;
  final VoidCallback onShare;
  final VoidCallback onFavorite;
  final bool isfavorite;

  const MediumThumbnailCard({
    super.key,
    required this.thumbnail,
    required this.channelName,
    required this.avatar,
    required this.title,
    required this.views,
    required this.date,
    required this.onTap,
    required this.onFavorite,
    required this.onShare,
    this.isfavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        thumbnail,
                        width: 150,
                        height: 95,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (isfavorite)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                            color: AppColor.black900.withAlpha(190),
                          ),
                          child: Image.asset(
                            'assets/icons/favorite_green_fill.png',
                            height: 16,
                            width: 16,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                  ],
                ),
                AppDimension.w12,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          text: title,
                          fontSize: 16,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                          color: AppColor.deepGreen,
                        ),

                        Row(
                          children: [
                            customText(
                              text: channelName,
                              color: AppColor.black600,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                            AppDimension.w8,
                            Image.asset(
                              'assets/icons/green_badge.png',
                              height: 14,
                              width: 14,
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            customText(
                              text: views,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black600,
                            ),
                            AppDimension.w16,
                            customText(
                              text: date,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black600,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ThreeDotButton(
                  assetFavoriteIcon: 'assets/icons/favorite_black.png',
                  onShare: onShare,
                  onFavorite: onFavorite,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
