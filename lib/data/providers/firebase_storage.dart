import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class StorageProvider {
  final FirebaseStorage storage = FirebaseStorage.instance;
  RxString imageUrl = ''.obs;

  Future<void> uploadImage(File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = storage.ref().child("tellMe_uploads/$fileName.jpg");

      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String url = await snapshot.ref.getDownloadURL();
      imageUrl.value = url;
      log("Image uploaded successfully: $url");
    } catch (e) {
      log("Upload failed: $e");
    }
  }
}
