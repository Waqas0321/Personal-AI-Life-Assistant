import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../core/Const/app_colors.dart';
import '../../../../core/Const/app_images.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_input_textfield.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../controller/forget_password_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final ForgetPasswordController controller =
      Get.find<ForgetPasswordController>();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: appSizes.getCustomPadding(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.logo,
                    width: appSizes.getWidthPercentage(28),
                    height: appSizes.getHeightPercentage(20),
                  ),
                  const CustomTextWidget(
                    text: "Reset Password!",
                    textColor: AppColors.black,
                    textOverflow: TextOverflow.visible,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                  const Gap(18),
                  SizedBox(
                    width: appSizes.getWidthPercentage(80),
                    child: const CustomTextWidget(
                      text:
                          "Please enter your account email to reset your password!",
                      textColor: AppColors.blackish,
                      textOverflow: TextOverflow.visible,
                    ),
                  ),
                  const Gap(18),
                  CustomInputTextField(
                    hintText: "Enter your email",
                    textEditingController: controller.emailController,
                    labelText: "Email",
                  ),
                  const Gap(23),
                  Obx(
                    () => CustomElevatedButton(
                      isLoading: controller.isLoading.value,
                      onPress: () async {
                        if (controller.emailController.text.isNotEmpty) {
                        } else {
                          controller.toast.showCustomToast(
                            "Please enter your email",
                          );
                        }
                      },
                      text: "Reset Password",
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
