import 'package:flutter/material.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/presentation/widgets/button/custom_icon_button.dart';

class SocialButtons extends StatelessWidget {
  final VoidCallback onFacebookTap;
  final VoidCallback onGoogleTap;
  final VoidCallback onLinkedInTap;

  const SocialButtons({
    super.key,
    required this.onFacebookTap,
    required this.onGoogleTap,
    required this.onLinkedInTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomIconButton(
          icon: Image.asset(
            'assets/icons/facebook_black.png',
            height: 20,
            fit: BoxFit.contain,
          ),
          onTap: onFacebookTap,
        ),
        AppDimension.w16,
        CustomIconButton(
          icon: Image.asset(
            'assets/icons/google_black.png',
            height: 17,
            fit: BoxFit.contain,
          ),
          onTap: onGoogleTap,
        ),
        AppDimension.w16,
        CustomIconButton(
          icon: Image.asset(
            'assets/icons/linkedin_black.png',
            height: 20,
            fit: BoxFit.contain,
          ),
          onTap: onLinkedInTap,
        ),
      ],
    );
  }
}
