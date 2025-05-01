import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/theme/text_design.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String assetIcon;
  final double iconSize;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.assetIcon,
    this.validator,
    required this.iconSize,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obsecured = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obsecured ? widget.isPassword : false,

      keyboardType: widget.keyboardType,
      validator: widget.validator,
      style: TextDesign().inputText,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 14,
            right: 2,
          ),
          child: Image.asset(
            widget.assetIcon,
            fit: BoxFit.contain,
            width: widget.iconSize,
            height: widget.iconSize,
          ),
        ),
        hintText: widget.hintText,
        hintStyle: TextDesign().hintText,
        filled: true,
        fillColor: AppColor.white,
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      obsecured = !obsecured;
                    });
                  },

                  icon: Image.asset(
                    'assets/icons/eye_white.png',
                    height: 28,
                    width: 28,
                  ),
                )
                : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColor.border, // Focused border color
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColor.border, // Enabled border color
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColor.red, // or AppColor.red if defined
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColor.red, // or AppColor.red
            width: 1,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      ),
    );
  }
}
