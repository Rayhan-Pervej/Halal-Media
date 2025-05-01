import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/presentation/widgets/button/custom_text_button.dart';
import 'package:halal_media/presentation/widgets/button/icon_text_button.dart';
import 'package:halal_media/presentation/widgets/button/three_dot_button.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_progress_indicator.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class VideoDetailSection extends StatelessWidget {
  final String title;
  final String metaText;
  final String channelName;
  final String subscriberCount;
  final bool isSubscribed;
  final bool isFavorite;
  final bool isDescriptionSelected;
  final String description;
  final VoidCallback onToggleSubscribe;
  final VoidCallback onToggleFavorite;
  final VoidCallback onShare;
  final VoidCallback onToggleDescription;
  final VoidCallback onShowMore;
  final Widget noteEditor;
  final bool isSubcribeLoading;

  const VideoDetailSection({
    super.key,
    required this.title,
    required this.metaText,
    required this.channelName,
    required this.subscriberCount,
    required this.isSubscribed,
    required this.isFavorite,
    required this.isDescriptionSelected,
    required this.description,
    required this.onToggleSubscribe,
    required this.onToggleFavorite,
    required this.onShare,
    required this.onToggleDescription,
    required this.onShowMore,
    required this.noteEditor,
    this.isSubcribeLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title & Meta
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  text: title,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  maxLines: 3,
                  lineHeight: 0,
                  overflow: TextOverflow.ellipsis,
                ),
                AppDimension.h8,
                customText(
                  text: metaText,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColor.black600,
                  maxLines: 2,
                  lineHeight: 0,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Channel Info & Actions
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Avatar & Name
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage("assets/icons/avatar_1.png"),
                    ),
                    AppDimension.w16,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          text: channelName,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          lineHeight: 0,
                        ),
                        AppDimension.h4,
                        customText(
                          text: subscriberCount,
                          fontSize: 12,
                          color: AppColor.black600,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ],
                ),
                // Subscribe + Favorite + Share
                Row(
                  children: [
                    TextButton(
                      onPressed: onToggleSubscribe,
                      style: TextButton.styleFrom(
                        backgroundColor: AppColor.green,
                      ),
                      child:
                          isSubscribed
                              ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: AppColor.white,
                                ),
                              )
                              : customText(
                                text: isSubscribed ? "SUBSCRIBED" : "SUBSCRIBE",
                                fontSize: 14,
                                color: AppColor.white,
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                    AppDimension.w10,
                    ThreeDotButton(
                      onShare: onShare,
                      assetFavoriteIcon:
                          isFavorite
                              ? 'assets/icons/favorite_green_fill.png'
                              : 'assets/icons/favorite_black.png',
                      onFavorite: onToggleFavorite,
                      backgroundColor: AppColor.gray200,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Toggle Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconTextButton(
                      assetIcon: 'assets/icons/note_black.png',
                      label: "Description",
                      gap: 5,
                      onTap: onToggleDescription,
                    ),
                    IconTextButton(
                      assetIcon: 'assets/icons/note_black.png',
                      label: "Add Note",
                      gap: 5,
                      onTap: onToggleDescription,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 3,
                  child: Stack(
                    children: [
                      Container(color: AppColor.gray200),
                      AnimatedAlign(
                        alignment:
                            isDescriptionSelected
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2 - 24,
                          height: 3,
                          decoration: BoxDecoration(
                            color: AppColor.green,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Description / Notes Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child:
                isDescriptionSelected
                    ? Container(
                      padding: const EdgeInsets.all(8),
                      height: 134,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColor.black200, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                            text: description,
                            fontSize: 12,
                            lineHeight: 0,
                            maxLines: 6,
                            color: AppColor.black900,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                          ),
                          AppDimension.h8,
                          CustomTextButton(
                            ontap: onShowMore,
                            text: "SHOW MORE",
                            color: AppColor.black900,
                          ),
                        ],
                      ),
                    )
                    : noteEditor,
          ),
        ],
      ),
    );
  }
}
