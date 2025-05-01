import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double size;

  const CustomProgressIndicator({super.key, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.discreteCircle(
      color: AppColor.deepGreen,
      secondRingColor: AppColor.green,
      thirdRingColor: AppColor.oragne,
      size: size,
    );
  }
}
