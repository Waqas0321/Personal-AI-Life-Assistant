import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../core/Const/app_colors.dart';
import '../../../core/Const/app_images.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_outline_button.dart';
import '../../../core/widgets/custom_text_widget.dart';
import '../../../data/models/user_model.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  ProfileController controller = Get.find<ProfileController>();
  AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: const CustomAppBar(goBack: true, title: "Profile"),
          body: StreamBuilder(
            stream: controller.getUserStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: CustomTextWidget(
                    text: "User not found",
                    textColor: AppColors.primary,
                  ),
                );
              } else {
                UserModel? user = snapshot.data;
                return Padding(
                  padding: AppSizes().getCustomPadding(),
                  child: Column(
                    children: [
                      const Gap(6),
                      CircleAvatar(
                        radius: 44,
                        backgroundImage:
                            user!.imagePath!.isEmpty
                                ? AssetImage(AppImages.logo)
                                : NetworkImage(user.imagePath!),
                      ),
                      const Gap(12),
                      CustomTextWidget(
                        text: "${user.firstName} ${user.lastName}",
                        textColor: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomTextWidget(
                        text: user.email,
                        textColor: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      const Gap(6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CustomTextWidget(
                            text: "Gender :",
                            textColor: AppColors.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          const Gap(8),
                          CustomTextWidget(
                            text: user.selectedGender,
                            textColor: AppColors.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: appSizes.getWidthPercentage(75),
                        child: CustomTextWidget(
                          text: user.about,
                          textColor: AppColors.primary,
                          fontSize: 14,
                          textOverflow: TextOverflow.visible,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Spacer(),
                      CustomOutlineButton(
                        onPress: () async {
                          await controller.auth.signOut();
                        },
                        text: "Sign Out",
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
