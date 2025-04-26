import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../Const/app_colors.dart';
import '../utils/app_sizes.dart';
import 'custom_elevated_button.dart';
import 'custom_text_widget.dart';
class CustomDialogBox{

  Future<void> showDeleteDialog({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: AppSizes().getCustomPadding(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.red, size: 50),
                Gap(12),
                CustomTextWidget(
                  text: title,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                Gap(6),
                CustomTextWidget(
                  text: message,
                  textAlign: TextAlign.center,
                  textOverflow: TextOverflow.visible,
                  fontSize: 12,
                ),
                Gap(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Cancel Button
                    Expanded(
                        child: CustomElevatedButton(
                          height: 40,
                          text: "Cancel",
                          backgroundColor: AppColors.blackish,
                          onPress: () {
                            Get.back();
                          },
                        )
                    ),

                    Gap(18),

                    /// Delete Button
                    Expanded(
                        child: CustomElevatedButton(
                          height: 40,
                          text: "Confirm",
                          backgroundColor: AppColors.red,
                          onPress: () {
                            Get.back();
                            onConfirm();
                          },
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

