import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SummariesController extends GetxController {
  final TextEditingController notesController = TextEditingController();
  final RxList<String> summarizedPoints = <String>[].obs;

  void summarizeNotes() {
    final text = notesController.text.trim();

    if (text.isEmpty) {
      summarizedPoints.clear();
      return;
    }
    List<String> sentences = text.split(RegExp(r'(?<=[.!?])\s+'));

    List<String> phrases = [];
    for (var sentence in sentences) {
      phrases.addAll(sentence.split(','));
    }

    List<String> cleanPhrases = phrases
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty && e.length > 10)
        .toList();

    cleanPhrases.sort((a, b) => a.length.compareTo(b.length));

    summarizedPoints.clear();
    int count = 0;
    for (var phrase in cleanPhrases) {
      if (phrase.trim().isNotEmpty) {
        summarizedPoints.add(phrase.trim());
        count++;
      }
      if (count >= 5) break;
    }
  }

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }
}
