import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class IconTextButton extends StatelessWidget {
  final String assetIcon;
  final String label;
  final double? labelSize;
  final VoidCallback onTap;
  final double gap;
  final double raidus;
  const IconTextButton({
    super.key,
    required this.assetIcon,
    required this.label,
    this.labelSize,
    required this.onTap,
    this.gap = 16,
    this.raidus = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor: AppColor.white,
        //iconColor: MyColor.black,
        //overlayColor: MyColor.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(raidus),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(assetIcon, height: 24, width: 24),
            SizedBox(width: gap),
            customText(
              color: AppColor.black900,
              text: label,
              fontSize: labelSize ?? 16,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
