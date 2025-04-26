import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../core/Const/app_colors.dart';
import '../../../../core/app_routes/routes.dart';
import '../../../../core/const/app_images.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_input_textfield.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../controller/signup_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpController controller = Get.find<SignUpController>();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Material(
          child: Center(
            child: SafeArea(
              child: Padding(
                padding: appSizes.getCustomPadding(),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => Container(
                            height: appSizes.getHeightPercentage(12),
                            width: appSizes.getWidthPercentage(28),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 0.5,
                                  color: AppColors.primary,
                                ),
                                image: controller.imagePicker.selectedImage
                                                .value ==
                                            null ||
                                        controller.imagePicker.selectedImage
                                                .value ==
                                            ''
                                    ? null
                                    : DecorationImage(
                                        image: FileImage(controller
                                            .imagePicker.selectedImage.value!),
                                        fit: BoxFit.cover)),
                            child: Stack(
                              children: [
                                controller.imagePicker.selectedImage.value ==
                                            null ||
                                        controller.imagePicker.selectedImage
                                                .value ==
                                            ''
                                    ? ClipOval(
                                        child: Padding(
                                          padding: const EdgeInsets.all(22.0),
                                          child: Image.asset(
                                            AppImages.logo,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                GestureDetector(
                                  onTap: () {
                                    controller.imagePicker
                                        .showImagePickerBottomSheet();
                                  },
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: AppColors.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(2),
                                      child: const Icon(
                                        Icons.camera,
                                        color: AppColors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Gap(16),
                        Row(
                          children: [
                            Expanded(
                              child: CustomInputTextField(
                                textEditingController:
                                    controller.firstNameController,
                                hintText: "Enter First Name",
                                labelText: "First Name",
                                isValidator: true,
                                emptyValueErrorText: "Please enter first name",
                              ),
                            ),
                            const Gap(16),
                            Expanded(
                              child: CustomInputTextField(
                                textEditingController:
                                    controller.lastNameController,
                                hintText: "Enter Last Name",
                                labelText: "Last Name",
                                isValidator: true,
                                emptyValueErrorText: "Please enter last name",
                              ),
                            ),
                          ],
                        ),
                        const Gap(16),
                        CustomInputTextField(
                          textEditingController: controller.emailController,
                          hintText: "Enter Email",
                          labelText: "Email",
                          isValidator: true,
                          emptyValueErrorText: "Please enter your email",
                        ),
                        const Gap(16),
                        CustomInputTextField(
                          textEditingController:
                              controller.createPasswordController,
                          hintText: "Create your Password",
                          labelText: "Create Password",
                          hasSuffixIcon: true,
                          isObsecure: true,
                          isValidator: true,
                          emptyValueErrorText: "Please create password",
                        ),
                        const Gap(16),
                        CustomInputTextField(
                          textEditingController:
                              controller.confirmPasswordController,
                          hintText: "Confirm your Password",
                          labelText: "Confirm Password",
                          hasSuffixIcon: true,
                          isObsecure: true,
                          isValidator: true,
                          emptyValueErrorText: "Please enter confirm password",
                        ),
                        const Gap(16),
                        const SizedBox(
                          width: double.infinity,
                          child: CustomTextWidget(
                            textAlign: TextAlign.start,
                            text: '  About',
                            textColor: AppColors.white,
                          ),
                        ),
                        const Gap(4),
                        SizedBox(
                          height: 100,
                          child: CustomInputTextField(
                            textEditingController: controller.aboutController,
                            hintText: "Write here...",
                            labelText: "Write here...",
                            maxLines: 5,
                            isValidator: true,
                            emptyValueErrorText:
                                "Please write something about you",
                          ),
                        ),
                        const Gap(16),
                        const SizedBox(
                          width: double.infinity,
                          child: CustomTextWidget(
                            textAlign: TextAlign.start,
                            text: '  Gender',
                            textColor: AppColors.white,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(() => Radio(
                                  value: 'Male',
                                  activeColor: AppColors.white,
                                  groupValue: controller.selectedGender.value,
                                  onChanged: (value) =>
                                      controller.selectedGender.value = value!,
                                )),
                            const CustomTextWidget(
                              textAlign: TextAlign.start,
                              text: 'Male',
                              textColor: AppColors.white,
                            ),
                            const Gap(16),
                            Obx(() => Radio(
                                  value: 'Female',
                                  activeColor: AppColors.white,
                                  groupValue: controller.selectedGender.value,
                                  onChanged: (value) =>
                                      controller.selectedGender.value = value!,
                                )),
                            const CustomTextWidget(
                              textAlign: TextAlign.start,
                              text: 'Female',
                              textColor: AppColors.white,
                            ),
                          ],
                        ),
                        const Gap(21),
                        Obx(
                          () => CustomElevatedButton(
                              isLoading: controller.isLoading.value,
                              onPress: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  if (controller
                                          .createPasswordController.text ==
                                      controller
                                          .confirmPasswordController.text) {
                                    controller.userSignUp();
                                  } else {
                                    controller.toast
                                        .showCustomToast("Passwords mismatch");
                                  }
                                } else {
                                  controller.toast.showCustomToast(
                                      "Please fill all fields");
                                }
                              },
                              text: "SIGN UP"),
                        ),
                        Gap(appSizes.getHeightPercentage(2)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomTextWidget(
                              text: "Already have an account?",
                              fontSize: 12,
                              textColor: AppColors.blackish,
                            ),
                            Gap(4),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.SIGNINSCREEN);
                              },
                              child: const CustomTextWidget(
                                text: "Sign In",
                                fontSize: 13,
                                textColor: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
