import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isNavbar;
  final bool bottomBorder;
  final String? title;
  final List<Widget>? appActionsBar;

  const CustomAppbar({
    super.key,
    this.isNavbar = true,
    this.bottomBorder = false,
    this.title,
    this.appActionsBar,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          bottomBorder
              ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColor.black200, width: 1),
                ),
              )
              : const BoxDecoration(),
      child:
          isNavbar
              ? AppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: AppColor.white,
                elevation: 0,
                leadingWidth: 180,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/icons/halal_media.png'),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/icons/notification_black.png',
                      height: 20,
                      width: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/icons/search_black.png',
                      height: 20,
                      width: 20,
                    ),
                  ),
                ],
              )
              : AppBar(
                backgroundColor: AppColor.white,
                elevation: 0,
                actionsPadding: EdgeInsets.only(right: 8),
                surfaceTintColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Iconsax.arrow_left_2),
                ),
                title: customText(
                  text: title ?? "",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                actions: appActionsBar,
              ),
    );
  }
}
