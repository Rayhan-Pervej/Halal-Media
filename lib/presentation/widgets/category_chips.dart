import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class CategoryChips extends StatefulWidget {
  final List<String> categories;
  final Function(String)? onCategorySelected;

  const CategoryChips({
    super.key,
    required this.categories,
    this.onCategorySelected,
  });

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  String selectedCategory = "All"; // Default selected category

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          widget.categories.map((category) {
            final bool isSelected = category == selectedCategory;

            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = category;
                  });
                  if (widget.onCategorySelected != null) {
                    widget.onCategorySelected!(category);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),

                  child: customText(
                    text: category,
                    color: isSelected ? AppColor.black900 : AppColor.gray600,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
