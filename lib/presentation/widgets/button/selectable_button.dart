import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class SelectableButton extends StatelessWidget {
  final String text;
  final String assetIcon;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableButton({
    super.key,
    required this.text,
    required this.assetIcon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: isSelected ? 4 : 0,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: isSelected ? AppColor.black50 : AppColor.white,
            border: Border.all(
              color: isSelected ? AppColor.green : AppColor.black400,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColor.black50,
                      border: Border.all(
                        color: isSelected ? AppColor.green : AppColor.black400,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Image.asset(
                      'assets/icons/${assetIcon}_${isSelected ? "green" : "black"}.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                  SizedBox(width: 24),
                  customText(
                    color: AppColor.black800,
                    text: text,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              Image.asset(
                'assets/icons/tik_${isSelected ? "green_fill" : "white"}.png',
                height: 24,
                width: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

