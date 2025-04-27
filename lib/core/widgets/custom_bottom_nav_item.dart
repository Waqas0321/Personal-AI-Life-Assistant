import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'custom_text_widget.dart';
class BottomNavItem extends StatelessWidget {
  final int index;
  final String iconPath;
  final String label;
  final RxInt currentIndex;
  final Color selectedColor;
  final Color unselectedColor;

  const BottomNavItem({
    Key? key,
    required this.index,
    required this.iconPath,
    required this.label,
    required this.currentIndex,
    required this.selectedColor,
    required this.unselectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        currentIndex.value = index;
      },
      child: Obx(() {
        final isSelected = currentIndex.value == index;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
              height: 24,
              width: 24,
            ),
            Gap(6),
            CustomTextWidget(
              text: label,
              fontSize: 11,
              textColor:
              isSelected ? Colors.white : Colors.white.withOpacity(0.7),
            ),
          ],
        );
      }),
    );
  }
}