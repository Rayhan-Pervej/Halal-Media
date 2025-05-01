import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart'; // adjust the import path as needed

class CustomDropdown extends StatelessWidget {
  final String selectedValue;
  final List<String> items;
  final void Function(String?) onChanged;

  const CustomDropdown({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          value: selectedValue,
          onChanged: onChanged,
          items:
              items
                  .map(
                    (value) => DropdownMenuItem<String>(
                      value: value,
                      child: customText(
                        text: value,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                  .toList(),

          customButton: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: 40,

            decoration: BoxDecoration(
              color: AppColor.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                customText(
                  text: selectedValue,
                  fontSize: 14,
                  color: AppColor.white,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(width: 4),
                Image.asset(
                  'assets/icons/arrow_down_white.png',
                  height: 20,
                  width: 20,
                ),
              ],
            ),
          ),

          dropdownStyleData: DropdownStyleData(
            width: 150,
            offset: const Offset(0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
