import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halal_media/core/theme/app_color.dart';

class TextDesign {
  TextStyle hintText = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColor.black400,
  );
  TextStyle inputText = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColor.black900,
  );
  TextStyle unselectedNavText = GoogleFonts.inter(
    fontSize: 12,
    color: AppColor.green,
  );
  TextStyle selectedNavText = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColor.green,
  );
}
