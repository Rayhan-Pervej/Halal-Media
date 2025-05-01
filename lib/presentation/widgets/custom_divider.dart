import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomDivider extends StatelessWidget {
  final double thickness;
  final double width;
  final double height;
  final Color? color;
  final EdgeInsetsGeometry margin;

  const CustomDivider({
    super.key,
    this.thickness = 1.0,
    this.width = double.infinity,
    this.height = 1.0,
    this.color,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color ?? HexColor("#000000").withAlpha(26),
      margin: margin,
    );
  }
}
