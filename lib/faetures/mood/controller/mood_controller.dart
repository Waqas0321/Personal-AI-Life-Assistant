import 'package:get/get.dart';
import '../../../core/widgets/custom_toast_show.dart';


class MoodController extends GetxController {
  var selectedMood = ''.obs;
  final ToastClass toast = ToastClass();

  void selectMood(String mood) {
    selectedMood.value = mood;
  }

  void saveMood() {
    toast.showCustomToast(
      'Your mood "${selectedMood.value}" has been saved successfully!',
    );
  }

  void clear() {
    selectedMood.value = '';
  }
}