import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';

class CreatorChips extends StatefulWidget {
  final List<String> subscribedCreator;
  const CreatorChips({super.key, required this.subscribedCreator});

  @override
  State<CreatorChips> createState() => _CreatorChipsState();
}

class _CreatorChipsState extends State<CreatorChips> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          widget.subscribedCreator.asMap().entries.map((entry) {
            int index = entry.key;
            String assetPath = entry.value;

            bool isSelected = selectedIndex == index;

            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppColor.green : Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Image.asset(assetPath, height: 50, width: 50),
                ),
              ),
            );
          }).toList(),
    );
  }
}
