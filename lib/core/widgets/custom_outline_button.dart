import 'package:flutter/material.dart';
import '../Const/app_colors.dart';
import 'custom_text_widget.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    super.key,
    required this.onPress,
    required this.text,
    this.height = 50,
    this.width = double.infinity,
    this.borderColor = AppColors.red,
    this.borderRadius = 13,
    this.textColor = AppColors.red,
  });

  final Color textColor;
  final VoidCallback onPress;
  final String text;
  final double height;
  final double width;
  final Color borderColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: onPress,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: borderColor,
            width: 0.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child:  CustomTextWidget(
          text: text,
          fontSize: 15,
          textColor: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
