import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class OCRProvider {
  final ImagePicker picker = ImagePicker();
  final TextRecognizer textRecognizer = TextRecognizer();

  /// Pick image from camera or gallery
  Future<File?> pickImage({bool fromCamera = true}) async {
    final pickedFile = await picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  /// Extract text from the given image
  Future<List<String>> extractTasksFromImage(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final RecognizedText recognizedText = await textRecognizer.processImage(
      inputImage,
    );

    List<String> tasks = [];

    for (var block in recognizedText.blocks) {
      for (var line in block.lines) {
        if (line.text.trim().isNotEmpty) {
          tasks.add(line.text.trim());
        }
      }
    }

    return tasks;
  }

  void dispose() {
    textRecognizer.close();
  }
}
