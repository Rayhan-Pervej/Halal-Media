import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class MenuButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const MenuButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: customText(
        text: title,
        fontSize: 16,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        color: isSelected ? AppColor.green : AppColor.black800,
      ),
    );
  }
}
