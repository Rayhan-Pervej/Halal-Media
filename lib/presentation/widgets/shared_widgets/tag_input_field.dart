import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/theme/text_design.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class TagInputField extends StatelessWidget {
  final List<String> tags;
  final TextEditingController controller;
  final void Function(String tag) onAddTag;
  final void Function(String tag) onRemoveTag;

  const TagInputField({
    super.key,
    required this.tags,
    required this.controller,
    required this.onAddTag,
    required this.onRemoveTag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.black600),
        borderRadius: BorderRadius.circular(6),
        color: AppColor.white,
      ),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 4,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            ...tags.map(
              (tag) => Chip(
                label: customText(
                  text: tag,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.deepGreen,
                ),
                backgroundColor: AppColor.green.withOpacity(1),
                deleteIcon: Icon(
                  Icons.close,
                  size: 18,
                  color: AppColor.deepGreen,
                ),
                onDeleted: () => onRemoveTag(tag),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 150),
              child: Container(
                height: 32, // match the Chip height
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: TextField(
                  controller: controller,
                  style: const TextStyle(fontSize: 14, height: 1.2),
                  decoration: InputDecoration(
                    hintText: 'Add tag',
                    hintStyle: TextDesign().hintText,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  maxLines: 1,
                  onChanged: (value) {
                    if (value.endsWith(' ') ||
                        value.endsWith(',') ||
                        value.endsWith('\n')) {
                      onAddTag(value);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
