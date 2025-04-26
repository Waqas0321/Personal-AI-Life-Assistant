import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class OCRService {
  final _textRecognizer = TextRecognizer();

  Future<String?> extractTextFromImage(File image) async {
    try {
      final inputImage = InputImage.fromFile(image);
      final recognizedText = await _textRecognizer.processImage(inputImage);
      return recognizedText.text;
    } catch (e) {
      print('Error in text recognition: $e');
      return null;
    }
  }

  Future<File?> pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  Future<File?> captureImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  void dispose() {
    _textRecognizer.close();
  }
}