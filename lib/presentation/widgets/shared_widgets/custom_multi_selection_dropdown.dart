import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/theme/text_design.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class CustomMultiSelectDropdown extends StatefulWidget {
  final String hintText;
  final List<String> items;
  final List<String> selectedItems;
  final Function(List<String>) onSelectionChanged;
  final String? assetIcon;
  final double iconSize;
  final bool showPrefixIcon;
  final bool showLabel;
  final String? labelText;

  const CustomMultiSelectDropdown({
    super.key,
    required this.hintText,
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
    this.assetIcon,
    this.iconSize = 20,
    this.showPrefixIcon = true,
    this.showLabel = false,
    this.labelText,
  });

  @override
  State<CustomMultiSelectDropdown> createState() =>
      _CustomMultiSelectDropdownState();
}

class _CustomMultiSelectDropdownState extends State<CustomMultiSelectDropdown> {
  bool _isDropdownOpen = false;

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  void _handleSelection(String item) {
    setState(() {
      if (widget.selectedItems.contains(item)) {
        widget.selectedItems.remove(item);
      } else {
        widget.selectedItems.add(item);
      }
      widget.onSelectionChanged(widget.selectedItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel && widget.labelText != null) ...[
          customText(
            text: widget.labelText!,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColor.black800,
          ),
          const SizedBox(height: 8),
        ],
        GestureDetector(
          onTap: _toggleDropdown,
          child: InputDecorator(
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextDesign().hintText,
              filled: true,
              fillColor: AppColor.white,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 14,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColor.green),
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
            ),
            child: Row(
              children: [
                if (widget.showPrefixIcon && widget.assetIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Image.asset(
                      widget.assetIcon!,
                      width: widget.iconSize,
                      height: widget.iconSize,
                    ),
                  ),
                Expanded(
                  child: Text(
                    widget.selectedItems.isNotEmpty
                        ? widget.selectedItems.join(', ')
                        : widget.hintText,
                    style:
                        widget.selectedItems.isNotEmpty
                            ? TextDesign().inputText
                            : TextDesign().hintText,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset(
                  "assets/icons/arrow_down_white.png",
                  height: 20,
                  width: 20,
                ),
              ],
            ),
          ),
        ),

        if (_isDropdownOpen)
          Container(
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.black600),
              borderRadius: BorderRadius.circular(8),
              color: AppColor.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 10,
                runSpacing: 8,
                children:
                    widget.items.map((item) {
                      final isSelected = widget.selectedItems.contains(item);
                      return InkWell(
                        onTap: () => _handleSelection(item),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              isSelected
                                  ? 'assets/icons/tik_green_fill.png'
                                  : 'assets/icons/tik_white.png',
                              width: 18,
                              height: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(item, style: TextDesign().inputText),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
      ],
    );
  }
}
