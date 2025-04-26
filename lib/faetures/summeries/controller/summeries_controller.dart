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

    List<String> cleanSentences = sentences
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty && e.length > 20)
        .toList();

    cleanSentences.sort((a, b) => a.length.compareTo(b.length));

    summarizedPoints.clear();
    int count = 0;
    for (var sentence in cleanSentences) {
      if (sentence.length > 130) {
        summarizedPoints.add(sentence.substring(0, 117) + '...');
      } else {
        summarizedPoints.add(sentence);
      }
      count++;
      if (count >= 5) break;
    }
  }

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }
}
