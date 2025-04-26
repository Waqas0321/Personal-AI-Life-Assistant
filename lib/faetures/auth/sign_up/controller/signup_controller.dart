import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes/routes.dart';
import '../../../../core/widgets/custom_toast_show.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/providers/firebase_storage.dart';
import '../../../../data/providers/firestore_provider.dart';
import '../../../../data/providers/image_picker.dart';
import '../../../../data/providers/user_provider.dart';
import '../../../../data/shared_preference/shared_preference_services.dart';

class SignUpController extends GetxController {
  ImagePickerHelper imagePicker = ImagePickerHelper();
  ToastClass toast = ToastClass();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserProvider auth = UserProvider();
  FireStoreProvider fireStore = FireStoreProvider();
  StorageProvider storage = StorageProvider();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController createPasswordController =
      TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  RxString selectedGender = 'Male'.obs;
  File? imagePath = ImagePickerHelper().selectedImage.value;
  RxBool isLoading = false.obs;

  Future<void> userSignUp() async {
    try {
      isLoading.value = true;
      await storage.uploadImage(imagePicker.selectedImage.value!).then(
            (value) async{
          await auth.signUp(emailController.text.trim(),
              createPasswordController.text.trim())
              .then(
                (value) async{
              String? userId = await PreferenceHelper.getString("userID");
              UserModel user = UserModel(
                  firstName: firstNameController.text.trim(),
                  lastName: lastNameController.text.trim(),
                  email: emailController.text.trim(),
                  about: aboutController.text.trim(),
                  userID: userId,
                  imagePath: storage.imageUrl.value,
                  selectedGender: selectedGender.value);
              await fireStore
                  .storeDataWithUserID(
                  collectionName: "personal_ai_users",
                  data: user,
                  toJson: (user) => user.toJson())
                  .then(
                    (value) {
                      refreshField();
                  Get.toNamed(AppRoutes.BOTTOMNAVSCREEN);
                },
              );
              return null;
            },
          );
        },
      );
    } catch (e) {
      log("Exception : $e");
    } finally {
      isLoading.value = false;
    }
  }

  void refreshField(){
    imagePicker.selectedImage.value = null;
    storage.imageUrl.value = '';
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    createPasswordController.clear();
    confirmPasswordController.clear();
    aboutController.clear();
    selectedGender.value = 'Male';
  }

  @override
  void dispose() {
    super.dispose();
    refreshField();
  }
}
