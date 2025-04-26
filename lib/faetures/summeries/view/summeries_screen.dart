import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:personal_ai_life_assistant/core/Const/app_colors.dart';
import 'package:personal_ai_life_assistant/core/utils/app_sizes.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_text_widget.dart';
import 'package:personal_ai_life_assistant/faetures/summeries/controller/summeries_controller.dart';

class SummeriesScreen extends StatelessWidget {
  SummeriesScreen({super.key});

  final SummeriesController controller = Get.find();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(child: CustomTextWidget(text: "Summeries")),
    );
  }
}
