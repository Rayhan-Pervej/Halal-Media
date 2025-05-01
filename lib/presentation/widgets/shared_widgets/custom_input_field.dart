import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/theme/text_design.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/core/utils/validator.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLength;
  final TextInputType keyboardType;
  final bool isMultiline;
  final FormFieldValidator<String>? validatorClass;

  const CustomInputField({
    super.key,
    required this.label,
    required this.controller,
    this.maxLength = 200,
    this.keyboardType = TextInputType.text,
    this.isMultiline = false,
    this.validatorClass,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText(
          text: label,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColor.black800,
        ),
        const SizedBox(height: 6),
        TextFormField(
          style: TextDesign().inputText,
          controller: controller,
          maxLength: maxLength,
          keyboardType: isMultiline ? TextInputType.multiline : keyboardType,
          maxLines: isMultiline ? 10 : 1,
          minLines: isMultiline ? 10 : 1,
          validator: validatorClass ?? ValidatorClass().noValidationRequired,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 14,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.black600),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.black600),
            ),
            counterText: '',
          ),
        ),
        AppDimension.h2,
        Align(
          alignment: Alignment.centerRight,
          child: ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, value, child) {
              return customText(
                text: "${controller.text.length}/$maxLength",
                fontSize: 14,
                color: AppColor.black600,
              );
            },
          ),
        ),
      ],
    );
  }
}
