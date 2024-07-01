import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../my_profile_view/my_profile_controller.dart';

class EditProfileController extends GetxController {
  MyProfileController myProfileController = Get.find<MyProfileController>();
  TextEditingController fullController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController handleController = TextEditingController();
  XFile? coverPhoto;
  XFile? profilePhoto;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  GetUserByIdModel getUserByIdModel = GetUserByIdModel();

  RxBool isLoading = false.obs;

  getUserById({required String userId}) async {
    isLoading.value = true;
    // getUserByIdModel = await ApiRepository.getUserById(userId: userId);
    isLoading.value = false;
  }

  editProfile() async {
    if (bioController.text.trim().isEmpty) {
      Get.snackbar("Warning", "Bio can't be empty");
      return;
    }
    bool isUpdate = await ApiRepository.editProfile(
        bio: bioController.text,
        coverPhotoPath: coverPhoto?.path,
        fullName: fullController.text,
        handle: handleController.text,
        profilePhotoPath: profilePhoto?.path
    );
    if (isUpdate) {
      Get.back();
      myProfileController.getProfile();
    }
  }
}
