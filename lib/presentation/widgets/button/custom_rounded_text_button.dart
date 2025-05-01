import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class CustomRoundedTextButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final double? horizontalPadding;

  const CustomRoundedTextButton({
    super.key,
    this.text,
    this.child,
    this.backgroundColor,
    this.borderColor,
    this.onPressed,
    this.textColor,
    this.style,
    this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style:
          style ??
          TextButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor ?? AppColor.black900,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(360),
              side: BorderSide(color: borderColor ?? AppColor.gray200),
            ),
          ),
      child:
          child ??
          customText(
            text: text ?? '',
            color: textColor ?? AppColor.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
    );
  }
}
