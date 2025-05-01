import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import '../shared_widgets/custom_text _widget.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback ontap;
  final String text;
  final double fontSize;
  final Color? color;
  final TextDecoration? decoration;
  const CustomTextButton({
    super.key,
    required this.ontap,
    required this.text,
    this.fontSize = 14,
    this.color,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: ontap,
        child: customText(
          text: text,
          decoration: decoration,
          fontSize: fontSize,
          color: color ?? AppColor.green,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
