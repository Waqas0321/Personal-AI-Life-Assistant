import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_appbar.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_elevated_button.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_input_textfield.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_text_widget.dart';
import 'package:personal_ai_life_assistant/faetures/summeries/controller/summeries_controller.dart';
import 'package:gap/gap.dart';

import '../../../core/Const/app_colors.dart';

class SummariesScreen extends StatelessWidget {
  SummariesScreen({super.key});

  final SummariesController controller = Get.put(SummariesController ());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
     appBar: CustomAppBar(
       title: "Summarize Notes",
     ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextWidget(
                text: "Enter Your Long Notes:",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              const Gap(12),
              CustomInputTextField( labelText: "Write your notes here...",
                hintText: "Paste or type your notes here...",
                maxLines: 15, textEditingController: controller.notesController,
              ),
              const Gap(20),
              CustomElevatedButton(text: "Summarize",
                onPress: controller.summarizeNotes,
              ),
              const Gap(20),
              const CustomTextWidget(
                text: "Summary:",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              const Gap(10),
              Obx(() => controller.summarizedPoints.isEmpty
                  ? const CustomTextWidget(text: "No summary available yet.")
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.summarizedPoints.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("•  ", style: TextStyle(fontSize: 16)),
                        Expanded(
                          child: Text(
                            controller.summarizedPoints[index],
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
