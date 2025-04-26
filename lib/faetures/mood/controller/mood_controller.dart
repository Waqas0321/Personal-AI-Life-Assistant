import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/widgets/custom_toast_show.dart';

class MoodController extends GetxController {
  var selectedMood = ''.obs;
  final ToastClass toast = ToastClass();

  void selectMood(String mood) {
    selectedMood.value = mood;
  }

  final List<Map<String, dynamic>> moods = [
    {'emoji': '😊', 'label': 'Happy'},
    {'emoji': '😐', 'label': 'Neutral'},
    {'emoji': '😢', 'label': 'Sad'},
    {'emoji': '😡', 'label': 'Angry'},
    {'emoji': '😴', 'label': 'Tired'},
    {'emoji': '🤩', 'label': 'Excited'},
  ];

  Future<void> saveMood() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedMood', selectedMood.value);

    toast.showCustomToast(
      'Your mood "${selectedMood.value}" has been saved successfully!',
    );
  }

  void clear() {
    selectedMood.value = '';
  }

  Future<void> loadSavedMood() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mood = prefs.getString('savedMood');
    if (mood != null) {
      selectedMood.value = mood;
    }
  }
}
