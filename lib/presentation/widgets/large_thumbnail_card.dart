import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/presentation/widgets/button/three_dot_button.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class LargeThumbnailCard extends StatelessWidget {
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

  const LargeThumbnailCard({
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        thumbnail,
                        height: MediaQuery.of(context).size.width * 9 / 16,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (isfavorite)
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                            color: AppColor.black900,
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: 4,
                    bottom: 8,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 36,
                                width: 36,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(avatar),
                                ),
                              ),
                              AppDimension.w16,
                              customText(
                                text: channelName,
                                color: AppColor.black600,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                              AppDimension.w8,
                              Image.asset(
                                'assets/icons/green_badge.png',
                                height: 14,
                                width: 14,
                              ),
                            ],
                          ),
                          ThreeDotButton(
                             assetFavoriteIcon:  'assets/icons/favorite_black.png',
                            onShare: onShare,
                            onFavorite: onFavorite,
                          ),
                        ],
                      ),
                      AppDimension.h4,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                            text: title,
                            fontSize: 16,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,

                            fontWeight: FontWeight.w400,
                            color: AppColor.deepGreen,
                          ),
                          AppDimension.h4,
                          Row(
                            children: [
                              customText(
                                text: views,
                                fontSize: 14,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
