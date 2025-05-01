import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class VideoPlaylistButton extends StatelessWidget {
  final String title;
  final String privacy;
  final String thumbnail1;
  final String thumbnail2;
  final String thumbnail3;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isThreeDot;

  const VideoPlaylistButton({
    super.key,
    required this.title,
    required this.privacy,
    required this.thumbnail1,
    required this.thumbnail2,
    required this.thumbnail3,
    required this.onTap,
    this.onEdit,
    this.onDelete,
    this.isThreeDot = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: 100,
                width: 175,
                child: Stack(
                  children: [
                    _blurredThumbnail(thumbnail3),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: _blurredThumbnail(thumbnail2),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: _normalThumbnail(thumbnail1),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    text: title,
                    color: AppColor.black900,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    lineHeight: 0,
                  ),
                  customText(
                    text: privacy,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    lineHeight: 0,
                  ),
                ],
              ),
            ],
          ),
          if (isThreeDot) _threeDot(oneEdit: onEdit!, onDelete: onDelete!),
        ],
      ),
    );
  }

  Widget _blurredThumbnail(String assetPath) {
    return SizedBox(
      height: 90,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Image.asset(assetPath, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _normalThumbnail(String assetPath) {
    return SizedBox(
      height: 90,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(assetPath, fit: BoxFit.cover),
      ),
    );
  }

  Widget _threeDot({
    required VoidCallback oneEdit,
    required VoidCallback onDelete,
  }) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      iconColor: AppColor.deepGreen,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
      ),

      offset: const Offset(0, 40), // Show popup below the icon
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: AppColor.white,
      onSelected: (value) {
        if (value == 'delete') {
          oneEdit;
        } else if (value == 'Edit') {
          onDelete;
        }
      },
      itemBuilder:
          (context) => [
            PopupMenuItem(
              value: 'Delete',
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/delete_black.png',
                    height: 20,
                    width: 20,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 8),
                  Text('Delete'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'Edit',
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/note_black.png',
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
          ],
    );
  }
}
