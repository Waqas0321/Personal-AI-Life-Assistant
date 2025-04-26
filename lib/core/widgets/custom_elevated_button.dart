import 'package:flutter/material.dart';
import '../Const/app_colors.dart';
import 'custom_text_widget.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPress,
    required this.text,
    this.height = 50,
    this.width = double.infinity,
    this.borderRadius = 13,
    this.backgroundColor = AppColors.primary,
    this.textColor = AppColors.white,
    this.isLoading = false,
  });

  final VoidCallback onPress;
  final String text;
  final double height;
  final double width;
  final double borderRadius;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.white,
          backgroundColor: backgroundColor,
          // Button foreground (text) color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                ))
            : CustomTextWidget(
                text: text,
                textColor: textColor,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
      ),
    );
  }
}
