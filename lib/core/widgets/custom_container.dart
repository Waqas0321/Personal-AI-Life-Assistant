import 'package:flutter/material.dart';
import '../Const/app_colors.dart';
import 'package:get/get.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.imagePath,
    required this.screenPath,
  });

  final String imagePath;
  final String screenPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(screenPath);
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: Image.asset(imagePath)),
      ),
    );
  }
}