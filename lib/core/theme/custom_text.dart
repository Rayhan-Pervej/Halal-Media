
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halal_media/core/theme/app_color.dart';

Widget customTextWdiget({
  required String text,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  double? lineHeight,
  TextDecoration? decoration,
  TextDirection? textDirection,
  TextAlign? textAlign,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  String? fontFamily,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    textDirection: textDirection,
    overflow: overflow,
    style: GoogleFonts.inter(
      color: color,
      backgroundColor: AppColor.black900,
      fontSize: fontSize ?? 12,
      fontStyle: fontStyle,
      height: lineHeight,
      //fontFamily: fontFamily ,
      decoration: decoration,
      decorationColor: color,
      fontWeight: fontWeight,
    ),
  );
}


Widget titleTextWidget({
  required String text,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  double? lineHeight,
  TextDecoration? decoration,
  TextDirection? textDirection,
  TextAlign? textAlign,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  String? fontFamily,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    textDirection: textDirection,
    overflow: overflow,
    style: GoogleFonts.poppins(
      color: color,
      backgroundColor: AppColor.black900,
      fontSize: fontSize ?? 12,
      fontStyle: fontStyle,
      height: lineHeight,
      //fontFamily: fontFamily ,
      decoration: decoration,
      decorationColor: color,
      fontWeight: fontWeight,
    ),
  );
}
