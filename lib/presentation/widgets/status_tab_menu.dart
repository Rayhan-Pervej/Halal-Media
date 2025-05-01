import 'package:flutter/material.dart';
import 'package:halal_media/presentation/widgets/button/menu_button.dart';

class StatusTabMenu extends StatefulWidget {
  final List<String> tabs;
  final String initialTab;
  final ValueChanged<String> onTabSelected;

  const StatusTabMenu({
    super.key,
    required this.tabs,
    required this.initialTab,
    required this.onTabSelected,
  });

  @override
  State<StatusTabMenu> createState() => _StatusTabMenuState();
}

class _StatusTabMenuState extends State<StatusTabMenu> {
  late String selectedTab;

  @override
  void initState() {
    super.initState();
    selectedTab = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:
          widget.tabs.map((tab) {
            return MenuButton(
              title: tab,
              isSelected: selectedTab == tab,
              onTap: () {
                setState(() {
                  selectedTab = tab;
                });
                widget.onTabSelected(tab);
              },
            );
          }).toList(),
    );
  }
}
