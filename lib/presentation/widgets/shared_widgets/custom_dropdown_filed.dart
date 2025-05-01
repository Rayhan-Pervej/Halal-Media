import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/theme/text_design.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class CustomDropdownField extends StatelessWidget {
  final String hintText;
  final String? assetIcon;
  final double iconSize;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  // New additions
  final bool showPrefixIcon;
  final bool showLabel;
  final String? labelText;

  const CustomDropdownField({
    super.key,
    required this.hintText,
    this.assetIcon,
    required this.iconSize,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator,
    this.showPrefixIcon = true,
    this.showLabel = false,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel && labelText != null) ...[
          customText(
            text: labelText!,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColor.black800,
          ),
          const SizedBox(height: 8),
        ],
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          validator: validator,
          style: TextDesign().inputText,
          decoration: InputDecoration(
            prefixIcon:
                showPrefixIcon
                    ? Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 14,
                        right: 2,
                      ),
                      child: Image.asset(
                        assetIcon!,
                        fit: BoxFit.contain,
                        width: iconSize,
                        height: iconSize,
                      ),
                    )
                    : null,
            hintText: hintText,
            hintStyle: TextDesign().hintText,
            filled: true,
            fillColor: AppColor.white,

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.black600),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.black600),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.red, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 14,
            ),
          ),
          icon: Image.asset(
            "assets/icons/arrow_down_black.png",
            height: 20,
            width: 20,
          ),
          dropdownColor: AppColor.white,
          items:
              items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item, style: TextDesign().inputText),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
