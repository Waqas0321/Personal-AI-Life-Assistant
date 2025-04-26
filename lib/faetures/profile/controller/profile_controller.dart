import 'package:get/get.dart';
import 'package:personal_ai_life_assistant/data/providers/firestore_provider.dart';
import 'package:personal_ai_life_assistant/data/providers/user_provider.dart';
import '../../../data/models/user_model.dart';


class ProfileController extends GetxController{
  FireStoreProvider fireStore = FireStoreProvider();
  UserProvider auth = UserProvider();
  Stream<UserModel?> getUserStream() {
    return fireStore.getDataByUserID(collectionName: "personal_ai_users", fromJson: UserModel.fromJson);
  }

}