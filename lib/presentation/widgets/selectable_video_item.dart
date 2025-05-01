import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/presentation/widgets/custom_divider.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';
import 'package:hexcolor/hexcolor.dart';

class SelectableVideoItem extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String thumbnailPath;
  final String title;
  final String subtitle;
  final String views;
  final String favorites;
  final String date;
  final String comments;

  final VoidCallback onPreview;
  final VoidCallback onPrivate;
  final VoidCallback onEdit;
  final VoidCallback onShare;
  final VoidCallback onDelete;
  final String status;

  const SelectableVideoItem({
    super.key,
    required this.isSelected,
    required this.comments,
    required this.onTap,
    required this.thumbnailPath,
    required this.title,
    required this.subtitle,
    required this.views,
    required this.favorites,
    required this.date,
    required this.onPreview,
    required this.onPrivate,
    required this.onEdit,
    required this.onShare,
    required this.onDelete,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.white : AppColor.gray50,
          border: Border.all(color: AppColor.black50, width: 1),
        ),
        child: Row(
          children: [
            // Custom checkbox
            // Padding(
            //   padding: const EdgeInsets.only(right: 12),
            //   child: Image.asset(
            //     isSelected
            //         ? 'assets/icons/tik_black_fill.png'
            //         : 'assets/icons/tik_white.png',
            //     width: 20,
            //     height: 20,
            //   ),
            // ),

            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                thumbnailPath,
                width: 150,
                height: 95,
                fit: BoxFit.cover,
              ),
            ),
            AppDimension.w8,

            // Title and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    text: title,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // AppDimension.h4,
                  // customText(
                  //   text: subtitle,
                  //   fontSize: 14,
                  //   color: Colors.black54,
                  //   maxLines: 1,
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                  AppDimension.h8,
                  Row(
                    children: [
                      customText(
                        text: "$views views",
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                      AppDimension.w6,
                      CustomDivider(
                        width: 2,
                        height: 2,
                        color: AppColor.black900,
                      ),
                      AppDimension.w6,
                      customText(
                        text: date,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      customText(
                        text: "$favorites likes",
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                        lineHeight: 2,
                      ),
                      AppDimension.w6,
                      CustomDivider(
                        width: 2,
                        height: 2,
                        color: AppColor.black900,
                      ),
                      AppDimension.w6,
                      customText(
                        text: "$comments comments",
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                        lineHeight: 2,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Popup Menu
            PopupMenuButton<String>(
              color: AppColor.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(color: HexColor("#2020201A"), width: 1),
              ),
              elevation: 0,
              style: ButtonStyle(
                padding: WidgetStateProperty.all(EdgeInsets.zero),
                minimumSize: WidgetStateProperty.all(Size(0, 0)),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
              icon: const Icon(Icons.more_vert, size: 25),
              onSelected: (value) {
                switch (value) {
                  case 'preview':
                    onPreview();
                    break;
                  case 'private':
                    onPrivate();
                    break;
                  case 'edit':
                    onEdit();
                    break;
                  case 'share':
                    onShare();
                    break;
                  case 'delete':
                    onDelete();
                    break;
                }
              },
              itemBuilder: (context) {
                final lowerStatus = status.toLowerCase();
                final List<PopupMenuEntry<String>> menuItems = [];

                if (lowerStatus == 'active') {
                  menuItems.addAll([
                    _buildMenuItem('preview', "Preview"),
                    _buildMenuItem('private', "Private"),
                    _buildMenuItem('edit', "Edit"),
                    _buildMenuItem('share', "Share"),
                    _buildMenuItem('delete', "Delete"),
                  ]);
                } else if (lowerStatus == 'drafts') {
                  menuItems.addAll([
                    _buildMenuItem('edit', "Edit"),
                    _buildMenuItem('delete', "Delete"),
                  ]);
                } else if (lowerStatus == 'pending' ||
                    lowerStatus == 'rejected') {
                  menuItems.addAll([
                    _buildMenuItem('preview', "Preview"),
                    _buildMenuItem('edit', "Edit"),
                    _buildMenuItem('delete', "Delete"),
                  ]);
                } else if (lowerStatus == 'private') {
                  menuItems.addAll([
                    _buildMenuItem('preview', "Preview"),
                    _buildMenuItem('edit', "Edit"),
                    _buildMenuItem('share', "Share"),
                    _buildMenuItem('delete', "Delete"),
                  ]);
                }

                return menuItems;
              },
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildMenuItem(String value, String label) {
    return PopupMenuItem<String>(
      height: 30,
      value: value,
      child: customText(text: label, fontSize: 14, color: AppColor.black900),
    );
  }
}
