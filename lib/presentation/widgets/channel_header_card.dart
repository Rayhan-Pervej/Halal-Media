import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/presentation/widgets/button/custom_rounded_text_button.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class ChannelHeaderCard extends StatelessWidget {
  final String imagePath;
  final String channelName;
  final String subscriberCount;
  final String userName;

  final VoidCallback onUserTap;
  final VoidCallback onViewPressed;
  final VoidCallback onCustomizePressed;

  const ChannelHeaderCard({
    super.key,
    required this.imagePath,
    required this.channelName,
    required this.subscriberCount,
    required this.userName,
    required this.onUserTap,
    required this.onViewPressed,
    required this.onCustomizePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(360),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(360),
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),
              ),
              AppDimension.w16,

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 105, // Adjust this width as needed
                    child: customText(
                      text: channelName,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 105,
                    child: customText(
                      text: subscriberCount,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.black600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onUserTap,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 90, // slightly less to account for icon
                            child: customText(
                              text: userName,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black600,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Image.asset(
                            'assets/icons/arrow_right_black.png',
                            height: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              CustomRoundedTextButton(
                text: "View",
                backgroundColor: AppColor.green,
                borderColor: AppColor.green,
                onPressed: onViewPressed,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                ),
              ),
              AppDimension.w2,
              CustomRoundedTextButton(
                text: "Customize",

                borderColor: AppColor.green,
                onPressed: onCustomizePressed,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  backgroundColor: AppColor.gray200,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
